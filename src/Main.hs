module Main where

import Control.Applicative
import Control.Monad
import Data.Maybe
import Data.Monoid
import System.Environment
import qualified Data.IntMap as IM
import qualified Foreign.C.Math.Double as F

-- will i ever be fast enough to need Integer even on 64bit?  prob not
type I = Int
type R = (I, I, I, I)

cbrt = round . F.cbrt . fromIntegral

findCDs :: (I, I) -> [R]
findCDs (a, b) = do
  let s = cube a + cube b
  c <- [cbrt $ (s + 1) `div` 2 .. a - 1]
  let d3 = s - cube c
  case IM.lookup d3 cubeRev of
    Just d -> return (a, b, c, d)
    _ -> mempty
  where
  cubeL = map (^3) [1..a]
  cubeM = IM.fromDistinctAscList $ zip [1..a] cubeL
  cubeRev = IM.fromDistinctAscList $ zip cubeL [1..a]
  cube = fromJust . flip IM.lookup cubeM

main :: IO ()
main = do
  [f] <- getArgs
  aBs <- map ((\ [a, b] -> (read a, read b)) . words) . lines <$> readFile f
  putStr . unlines . map myShow $ concatMap findCDs aBs

myShow :: R -> String
myShow (a, b, c, d) = show a ++ " " ++ show b ++ " " ++ show c ++ " " ++ show d
