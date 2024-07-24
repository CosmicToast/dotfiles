(fn from-pairs [t ?mut]
  "Convert a list of [k v] pairs to a table.
   If an initial table ?mut is provided, it will be mutated and returned."
   (let [out (or ?mut {})]
    (each [_ [k v] (ipairs t)]
     (tset out k v))
    out))

(fn insert [t ...]
  "Like table.insert, but returns the mutated table."
  (table.insert t ...)
  t)

{: from-pairs
 : insert}
