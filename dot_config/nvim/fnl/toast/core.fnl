(local {: insert : unpack} (require :toast.table))

; math
(fn dec [n]
  "Decrement n by 1."
  (- n 1))
(fn inc [n]
  "Increment n by 1."
  (+ n 1))

; checks?
(fn empty? [xs]
  "Returns true if the lengthable contains no elements."
  (= 0 (length xs)))
(fn nil? [x]
  "Returns true if the argument is nil."
  (= nil x))
(fn number? [n]
  "Returns true if the argument is a number."
  (= :number (type n)))

; sequences
(fn drop [n xs]
  "Returns a table of all but the first n elements in xs."
  (let [out []]
   (each [i v (ipairs xs)]
    (when (> i n) (insert out v)))
   out))
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

; HOF
(fn assoc [?t ...]
  "Sets the key `k` in table `t` to the value `v`.
   Accepts an arbitrary amount of `k` and `v` pairs.
   Returns the mutated table `t`."
  (let [t (or ?t {})
        lt (inc (length t)) ; for numerical keys
        [k v & xs] [...]]
   (case k
    nil nil
    (where k (and (number? k) (> lt k))) (tset t k v) ; TODO: (set (. t k) v)
    (where k (and (number? k) (= k lt))) (table.insert t k v)
    _ (tset t k v))
   (case (length xs)
    0 t
    1 (error "assoc expects even number of arguments after table, found odd number")
    _ (assoc t (unpack xs)))))
(fn map [f xs]
  "Returns a sequential table consisting of the result of apply f to every item in xs."
  (accumulate [out []
               _ v (ipairs (or xs []))]
   (let [mapped (f v)]
    (insert out (if (= 0 (select :# mapped))
                    nil
                    mapped)))))

{;math
 : dec
 : inc
 ; checks?
 : empty?
 : nil?
 : number?
 ; sequences
 : drop
 : first
 : last
 : group
 ; HOF
 : assoc
 : map}
