module Main where

import Data.Bifunctor
import Data.List
import Data.List.Split

type Input = ([(Integer, Integer)], [[Integer]])

main :: IO ()
main = do
  input <- parseInput <$> readFile "input.txt"
  print $ part1 input
  print $ part2 input

part1 :: Input -> Integer
part1 (pairs, updates) = sum $ map middle $ filter (valid pairs) updates

valid :: [(Integer, Integer)] -> [Integer] -> Bool
valid pairs up = all (valid1 up) pairs
  where
    valid1 up (x, y) = x `notElem` dropWhile (y /=) up

middle :: [a] -> a
middle xs = xs !! (length xs `div` 2)

parseInput :: String -> Input
parseInput s = bimap (map parsePair) (map parseUpdate . tail) $ break null $ lines s
  where
    parsePair x = (read $ take 2 x, read $ drop 3 x)
    parseUpdate = map read . splitOn ","

part2 :: Input -> Integer
part2 (pairs, updates) = sum $ map (middle . order) $ filter (not . valid pairs) updates
  where
    order = sortBy pred
    
    pred x y | (x, y) `elem` pairs = LT
    pred x y | (y, x) `elem` pairs = GT
    pred x y = EQ