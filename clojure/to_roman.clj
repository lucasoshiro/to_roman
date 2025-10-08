(require '[clojure.string :as s])

(def roman-digits
  [""
   "i"
   "ii"
   "iii"
   "iv"
   "v"
   "vi"
   "vii"
   "viii"
   "ix"
   "x"
   ])

(def roman-symbols "IVXLCDM  ")

(defn toRoman [n]
  (let [rev    (-> n str s/reverse)
        algs   (map #(->> % str Integer/parseInt (get roman-digits)) rev)
        ivxs   (map vector
                    (take-nth 2 roman-symbols)
                    (->> roman-symbols rest (take-nth 2))
                    (->> roman-symbols (drop 2) (take-nth 2)))
        romans (map
                (fn [alg ivx]
                  (-> alg
                    (s/replace \i (get ivx 0))
                    (s/replace \v (get ivx 1))
                    (s/replace \x (get ivx 2))))
                algs ivxs)
        ]
    (s/join "" (reverse romans))))

(-> (read-line)
    Integer/parseInt
    toRoman
    println
 )
