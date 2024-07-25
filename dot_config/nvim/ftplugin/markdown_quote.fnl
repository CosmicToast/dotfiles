(local buf 0) ; operate on the current buffer on load

(fn location [opts]
  "Mutate or create ops.
   Line1 is the start of the selection, and Line2 is the end."
  (let [sl (or (?. opts :line1) (vim.fn.line :v))
        el (or (?. opts :line2) (vim.fn.line :.))
        swap (> sl el)]
   (if swap
     {:line1 (- 1 el)
      :line2 sl}
     {:line1 (- 1 sl)
      :line2 el})))

(fn maplines [f]
  "Returns a transducer that will map the selection's lines with f."
  (fn [opts]
   (let [opts (location opts)
         argp #(partial $1 buf opts.line1 opts.line2 true)
         setl (argp vim.api.nvim_buf_set_lines)
         getl (argp vim.api.nvim_buf_get_lines)]
    (setl (icollect [_ v (ipairs (getl))]
           (f v))))))

(let [+qf #(case $
            ; empty lines don't get quoted
            "" $

            ; unless there's already whitespace or an existing quote in front,
            ; we'll want to prepend ">" *and* a space
            ; this is the "unless" case
            (where s (s:match "^[%s>]"))
            (.. :> s)

            s
            (.. "> " s))
      -qf #(case $
            ; if the line starts with a "> " we remove both
            ; since it's no longer a quote at all
            (where s (s:match "^> "))
            (s:sub 3)

            ; else, we're just removing the ">" (a single quote level)
            (where s (s:match :^>))
            (s:sub 2)

            _ $)
      +quote (maplines +qf)
      -quote (maplines -qf)]
  (vim.api.nvim_buf_create_user_command buf :MdQuote   +quote { :range true})
  (vim.api.nvim_buf_create_user_command buf :MdDeQuote -quote { :range true})
  (vim.keymap.set [:n :x] :> +quote
                  {:buffer true
                   :desc "increase quote level of selection"})
  (vim.keymap.set [:n :x] :< -quote
                  {:buffer true
                   :desc "decrease quote level of selection"}))
