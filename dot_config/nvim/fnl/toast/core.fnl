(local {: insert} (require :toast.table))

(fn dec [n]
  "Decrement n by 1."
  (- n 1))
(fn inc [n]
  "Increment n by 1."
  (+ n 1))
(fn drop [n xs]
  "Returns a table of all but the first n elements in xs."
  (let [out []]
   (each [i v (ipairs xs)]
    (when (> i n) (insert out v)))
   out))
(fn empty? [xs]
  "Returns true if the lengthable contains no elements."
  (= 0 (length xs)))
(fn first [xs]
  "The first element in a sequential table."
  (. xs 1))
(fn last [xs]
  "The last element in a sequential table."
  (. xs (length xs)))
(fn group [n xs]
  "Group elements in xs in groups of n.
   Extra elements at the end will sit in the final group.
   For example, (group 2 [1 2 3 4 5]) results in [[1 2] [3 4] [5]].
   One exception is if xs is empty, in which case an empty collection is returned."
 (if (empty? xs)
   []
   (let [ll #(length (last $))
         donext #(= (ll $) n)]
    (accumulate [out [[]]
                 _ v (ipairs xs)]
     (do (when (donext out)
          (insert out []))
         (insert (last out) v
              out))))))
(fn map [f xs]
  "Returns a sequential table consisting of the result of apply f to every item in xs."
  (accumulate [out []
               _ v (ipairs xs)]
   (let [mapped (f v)]
    (insert out (if (= 0 (select :# mapped))
                    nil
                    mapped)))))

{: dec
 : inc
 : drop
 : empty?
 : group
 : first
 : last}
