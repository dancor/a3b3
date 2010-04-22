import FUtil

fI = fromIntegral

f :: Int -> Int -> String
f a b = show $ fI a / fI b

main = interactL $
  map ((\ [a, b, c, d] -> f a b ++ " " ++ f c d) . map read . words)
