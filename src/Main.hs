module Main where

-- a^3 + b^3 = c^3 + d^3
-- = (a + b)(a + q b)(a + q^2 b)
-- where q is a third root of unity.
-- we can factor the two sides in Z[q].

-- (a + b)^3 = a^3 + b^3 + 3ab^2 + 3a^2b

-- looking for primitive examples, we can assume:
-- - a > c and a = b and c > d, or
-- - a > c and a > b and c = d, or
-- - a > c and a > b and c > d.
-- we also know that b <= d.
-- if c = d, a^3 + b^3 = 2c^3.

-- mod 2:
-- a = b (mod 2)
-- mod 3:
-- a + b + c = 0 (mod 3)
-- mod 5:
-- 2 -> -2
-- mod 7:
-- 2 -> 1
-- 3 -> -1
-- mod 11:
-- 2 -> -3
-- 3 -> 5
-- 4 -> -2
-- 5 -> 3

-- since a = b + 2k,
-- a^3 + b^3 =
-- 2b^3 + 8k^3 + 6b^2k + 12bk^2 = 2c^3
-- we've got nothing

type I = Integer
type R = (I, I, I, I)

allWithACB :: I -> I -> I -> [R]
allWithACB a c b =

allWithAC :: I -> I -> [R]
allWithAC a c = concatMap (allWithACB a c) [1 .. a]

allWithA :: I -> [R]
allWithA a = concatMap (allWithAC cubes a) [1 .. a - 1]
  where cubes = [1 ..

main :: IO ()
main = do
  putStrLn "hi"
