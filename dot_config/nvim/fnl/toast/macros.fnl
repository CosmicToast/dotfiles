;; [nfnl-macro]

(local {: inc
        : drop
        : group} (require :toast.core))
(local {: from-pairs
        : insert} (require :toast.table))

(fn tbl [...]
  "Generate a mixed table.
   The format is (tbl 1 2 3 & :a :b) to produce {1; 2; 3; a = 'b'}.
   This macro simply expands to the correct data during compile-time."
 (let [args [...]
       pre (accumulate [out []
                        _ v (ipairs args)
                        &until (= v '&)]
            (insert out v))
       post (drop (inc (length pre)) args)]
  (from-pairs (group 2 post) pre)))

(fn recc [reqspec key ...]
  "A common lua pattern is `require 'something'.call(arg1, arg2)`.
   The fennel equivalent is ((require :something).call arg1 arg2)
   This macro makes it easier to do this elegantly.
   The equivalent call is (recc :something :call arg1 arg2)"
 `((. (require ,reqspec) ,key) ,...))

{: tbl
 : recc}
