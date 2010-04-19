module Main where

import Control.Monad
import Data.Maybe
import System.Environment
import qualified Data.IntMap as IM
import qualified Data.IntSet as IS
import qualified Foreign.C.Math.Double as F

-- will i ever be fast enough to need Integer even on 64bit?  prob not
type I = Int

cbrtCeil = ceiling . F.cbrt . fromIntegral

aUpTo :: I -> [(I, I, I)]
aUpTo n = do
  a <- [1..n]
  b <- [1..a]
  let s = cube a + cube b
  -- doing upper half (c from ceil) here is faster than lower half (d to floor)
  c <- [cbrtCeil $ s `div` 2 .. a - 1]
  guard $ IS.member (s - cube c) cubeS
  return (a, b, c)
  where
  cubeL = map (^3) [1..n]
  cubeS = IS.fromList cubeL
  cubeM = IM.fromDistinctAscList $ zip [1..n] cubeL
  cube = fromJust . flip IM.lookup cubeM

main :: IO ()
main = do
  [n] <- getArgs
  putStr . unlines . map show . aUpTo $ read n
