;; [nfnl-macro]

(local {: inc
        : drop
        : assoc
        : filter
        : even?
        : odd?
        : last} (require :toast.core))
(local {: insert : unpack : concat} (require :toast.table))

(fn mixed-table [...]
  "Generate a mixed table.
   The format is (mixed-table 1 2 3 & :a :b) to produce {1; 2; 3; a = 'b'}.
   This macro simply expands to the correct data during compile-time.
   It is recommended to import this as a single character macro locally."
 (let [args [...]
       ; groups, separated by &s
       grps (accumulate [out [[]]
                         _ v (ipairs args)]
             (if (= v '&)
              (insert out [])
              (do (table.insert (last out) v)
                  out)))
       kvs (concat (unpack (filter even? grps)))
       arr (concat (unpack (filter odd?  grps)))]
  (assoc arr (unpack kvs))))

(fn recc [reqspec key ...]
  "A common lua pattern is `require 'something'.call(arg1, arg2)`.
   The fennel equivalent is ((require :something).call arg1 arg2)
   This macro makes it easier to do this elegantly.
   The equivalent call is (recc :something :call arg1 arg2)"
 `((. (require ,reqspec) ,key) ,...))

{: mixed-table
 : recc}
