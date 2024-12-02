{-# LANGUAGE ViewPatterns #-}
module Main where

import Data.Bifunctor
import Data.List

type Input = [(Integer, Integer)]

main :: IO ()
main = do
  input <- parseInput <$> readFile "input.txt"
  print $ part1 input
  print $ part2 input

part1 :: Input -> Integer
part1 = sum . map (\(x, y) -> abs (x - y)) . uncurry zip . bimap sort sort . unzip

part2 :: Input -> Integer
part2 (unzip -> (xs, ys)) = sum $ filter (`elem` xs) ys

parseInput :: String -> Input
parseInput = map ((\[x, y] -> (read x, read y)) . words) . lines