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
(fn even? [n]
  "Returns true if the argument is an even number."
  (and (number? n) (= 0 (% n 2))))
(fn odd? [n]
  "Returns true if the argument is an odd number."
  (and (number? n) (not= 0 (% n 2))))

(fn every? [pred xs]
  "Returns true if (pred x) is logical true for every x in xs, else false."
  (accumulate [pass true
               _ x (ipairs xs)
               &until (not pass)]
   (pred x)))

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
    (where k (and (number? k) (> lt k))) (set (. t k) v)
    (where k (and (number? k) (= k lt))) (table.insert t v)
    _ (tset t k v))
   (case (length xs)
    0 t
    1 (error "assoc expects even number of arguments after table, found odd number")
    _ (assoc t (unpack xs)))))
; TODO: split into filter and kfilter?
(fn filter [f xs]
  "Returns a sequential table consisting only of elements in xs that return a truth value when passed to f.
   Note that the call will be (f k v), not (f v)."
  (accumulate [out []
               k v (ipairs xs)]
   (if (f k v)
     (insert out v)
    out)))
(fn map [f xs]
  "Returns a sequential table consisting of the result of apply f to every item in xs."
  (accumulate [out []
               _ v (ipairs (or xs []))]
   (let [mapped (f v)]
    (insert out (if (= 0 (select :# mapped))
                    nil
                    mapped)))))
; TODO: rework
(fn mapcat [f xs]
  (accumulate [out []
               _ v (ipairs xs)]
   (do (each [_ v (ipairs (f v))]
        (table.insert out v))
       out)))

; sequences cont
(fn flat [xs]
  "Flattens a sequential table xs such that there are no sub-tables."
  (case (type xs)
   :table (mapcat flat xs)
   _ [xs]))

{;math
 : dec
 : inc
 ; checks?
 : empty?
 : nil?
 : number?
 : even?
 : odd?
 : every?
 ; sequences
 : drop
 : first
 : last
 : group
 : flat
 ; HOF
 : assoc
 : filter
 : map
 : mapcat}
