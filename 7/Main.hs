{-# LANGUAGE ViewPatterns #-}

module Main where
import Debug.Trace

type Input = [(Integer, [Integer])]

main :: IO ()
main = do
  input <- parseInput <$> readFile "input.txt"
  print $ part1 input

part1 :: Input -> Integer
part1 = sum . map fst . filter solvable

solvable :: (Integer, [Integer]) -> Bool
solvable (n, xs) = n `elem` totals (reverse xs)

totals :: [Integer] -> [Integer]
totals [x] = [x]
totals (x : xs) = do
  op <- ops
  y <- totals xs
  pure $ x `op` y

ops :: [Integer -> Integer -> Integer]
ops = [(+), (*), conc]
  where
    conc x y = read $ show y ++ show x

parseInput :: String -> Input
parseInput = map parseLine . lines
  where
    parseLine s = do
      let (xs, drop 2 -> ys) = break (== ':') s
      (read xs, map read $ words ys)