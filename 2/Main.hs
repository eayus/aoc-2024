module Main where

import Data.Bifunctor
import Data.List

type Input = [[Integer]]

main :: IO ()
main = do
  input <- parseInput <$> readFile "input.txt"
  print $ part1 input
  print $ part2 input

part1 :: Input -> Int
part1 = length . filter isSafe
  where
    isSafe xs = cond1 xs && cond2 xs

part2 :: Input -> Int
part2 = length . filter isSafe
  where
    isSafe xs = or $ do
      i <- [0 .. length xs - 1]
      let xs' = deleteAt i xs
      [cond1 xs' && cond2 xs']

cond1 :: [Integer] -> Bool
cond1 xs = sort xs == xs || sort xs == reverse xs

cond2 :: [Integer] -> Bool
cond2 xs = do
  let pairs = zip xs (tail xs)
  all (\(x, y) -> let d = abs $ x - y in d >= 1 && d <= 3) pairs

deleteAt :: Int -> [a] -> [a]
deleteAt 0 (x : xs) = xs
deleteAt n (x : xs) = x : deleteAt (n - 1) xs

parseInput :: String -> Input
parseInput = map (map read . words) . lines