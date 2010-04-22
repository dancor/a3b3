import FUtil

fI = fromIntegral

f :: Int -> Int -> String
f x y = show $ fI x / fI y

main = interactL $
  map ((\ [a, b, c, d] -> f d c ++ " " ++ f b a) . map read . words)
