module Main where

import Data.List

type Input = [String]

-- Very ugly solution. It's definitely possible to be smarter and more efficient about this.
-- For example, to search for the backwards words we could just search for "SAMX", rather than
-- reversing each row. An alternative approach is to parse the input into an Array with constant
-- time indexing, which may actually be the nicest.

main :: IO ()
main = do
  input <- lines <$> readFile "input.txt"
  print $ part1 input
  print $ part2 input

part1 :: Input -> Integer
part1 input = countBothDiag input + countOrtho input
  where
    countBothDiag s = countDiag s + countDiag (map reverse s)
    countDiag s = countHoriz (transpose $ diagonalize s) + countHoriz (drop 1 $ transpose $ diagonalize $ transpose s)
    countOrtho s = countHoriz s + countVerti s
    countVerti = countHoriz . transpose
    countHoriz s = count s + count (map reverse s)
    count = sum . map countLine

countLine :: String -> Integer
countLine ('X':'M':'A':'S':cs) = 1 + countLine cs
countLine (c : cs) = countLine cs
countLine [] = 0

diagonalize :: [[a]] -> [[a]]
diagonalize [] = []
diagonalize (x : xs) = x : diagonalize (map (drop 1) xs)

part2 :: Input -> Int
part2 s = length $ filter isCross $ squares s

squares :: Input -> [[String]]
squares [] = []
squares xs | length (head xs) < 3 = []
squares xs = squaresCol xs ++ squares (map tail xs)

squaresCol :: Input -> [[String]]
squaresCol [] = []
squaresCol xs = takeSquare xs : squaresCol (tail xs)

takeSquare :: [[a]] -> [[a]]
takeSquare = map (take 3) . take 3

isCross :: [String] -> Bool
isCross xs | length xs < 3 || length (head xs) < 3 = False
isCross xs = s1 `elem` ss && s2 `elem` ss
  where
    s1 = zipWith (!!) xs indices
    s2 = zipWith (!!) xs (reverse indices)
    indices = [0..2]
    ss = ["MAS", "SAM"]