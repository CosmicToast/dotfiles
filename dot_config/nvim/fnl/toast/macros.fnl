;; [nfnl-macro]

(local {: inc
        : drop
        : assoc} (require :toast.core))
(local {: insert} (require :toast.table))

(fn mixed-table [...]
  "Generate a mixed table.
   The format is (mixed-table 1 2 3 & :a :b) to produce {1; 2; 3; a = 'b'}.
   This macro simply expands to the correct data during compile-time.
   It is recommended to import this as a single character macro locally."
 (let [args [...]
       pre (accumulate [out []
                        _ v (ipairs args)
                        &until (= v '&)]
            (insert out v))
       post (drop (inc (length pre)) args)]
  (assoc pre (unpack post))))

(fn recc [reqspec key ...]
  "A common lua pattern is `require 'something'.call(arg1, arg2)`.
   The fennel equivalent is ((require :something).call arg1 arg2)
   This macro makes it easier to do this elegantly.
   The equivalent call is (recc :something :call arg1 arg2)"
 `((. (require ,reqspec) ,key) ,...))

{: mixed-table
 : recc}