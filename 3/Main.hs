module Main where

import Text.Regex.PCRE

main :: IO ()
main = do
  input <- readFile "input.txt"
  print $ part1 input
  print $ part2 input

part1 :: String -> Integer
part1 input = do
  let matches = (input =~ regex :: [[String]])
  sum $ map (product . map read . tail) matches

part2 :: String -> Integer
part2 = part1 . keep
  where
    keep ('d':'o':'n':'\'':'t':'(':')':xs) = skip xs
    keep (x : xs) = x : keep xs
    keep [] = []

    skip ('d':'o':'(':')':xs) = keep xs
    skip (x : xs) = skip xs
    skip [] = []

regex :: String
regex = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"