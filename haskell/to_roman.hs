romanDigits = [""
              ,"i"
              ,"ii"
              ,"iii"
              ,"iv"
              ,"v"
              ,"vi"
              ,"vii"
              ,"viii"
              ,"ix"
              ,"x"
              ]

romanSymbols = "IVXLCDM  "

toRoman :: Int -> String
toRoman n = foldl1 (++) $ reverse romans
  where n_str  = show n
        rev    = reverse n_str
        algs   = map (read . pure) rev :: [Int]
        algs'  = map (romanDigits !!) algs
        ivx'   = zip3 romanSymbols (drop 1 romanSymbols) (drop 2 romanSymbols)
        ivx    = [x
                 | (i, x) <- zip [0..] ivx'
                 , i `mod` 2 == 0
                 ]
        romans = [[ case c of
                      'i' -> i
                      'v' -> v
                      'x' -> x
                  | c <- alg
                  ]
                 | (alg, (i, v, x)) <- zip algs' ivx
                 ]

main :: IO ()
main = do
  putStrLn "Enter a number: "
  line <- getLine
  let n = read line
  putStrLn . toRoman $ n
