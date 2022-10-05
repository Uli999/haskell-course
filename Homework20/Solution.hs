
import Control.Monad (forM)
import Data.Maybe (fromJust)
import Data.List (elemIndex)

-- Question 1
-- Rewrite the following code below that used do-notation to equivalent code that does not use do-notation. 

ioExample :: IO ()
ioExample = do
  print "Input number:"
  string <- getLine
  let n = read string
      add1 x = x + 1
  print (add1 n)
  
ioExample' :: IO () 
ioExample' = 
  print "Input number:" >>
    getLine >>= 
      (\string ->
        return ((\n -> 
                  (\add1 -> 
                    (add1 n)
                  ) (\x -> x + 1)
                ) (read string)
               )
      ) >>= 
      print

-- Question 2
-- Write a function that takes in n of type Int and returns a list of type Maybe [Int]. The elements of the 
-- list are combination counts for lists [1 .. x] where x goes from 1 to n. So the fisrt combination count is 
-- for the list [1], the second for the list [1,2] and the last for the list [1..n]. 

-- How to compute a combination count for a list: e.g. the list [1,2] has 4 possible combinations which are: 
-- (1,1) (1,2) (2,1) and (2,2). Do not use your knowledge of mathematics. Do it by computing all combination 
-- pairs and counting them. If the user inputs a negative number return a Nothing value. In your code try to 
-- simulate a for loop with the funtion forM. 

-- Additional challange: Try to write your code in a single function and make it as short as possible.

combinationCount :: Int -> Maybe [Int]
combinationCount n = do
    if n < 0 then Nothing else
      let
        allCombinations list = (\x y -> (x,y)) <$> list <*> list
        combCountList = forM [1..n] $ \i -> do
                          let combCount = length $ allCombinations [1..i]
                          return combCount
      in combCountList

-- Question 3
-- If you succesfully computed the function from the previous example you should get for n = 5 the list
-- [1,4,9,16,25] which clearly represents the function f(x) = x**2. Write now a function that uses the
-- fittingFunc defined below and finds the best exponent a from the input list of type [Double] that fits 
-- the function f(x) = x**2. So for instance for [1.5, 1.6 .. 2.5] it should return 2.0. Your fitting 
-- check should be done by calculating the mean squared error: (x - x1)^2 + ... + (x - xn)^2

-- Additional challange: Instead of using x**2 in your code use your solution function from Question 2.

fittingFunc :: Double -> Double -> Double
fittingFunc a x = x ** a

findExponent :: [Double] -> Double
findExponent candicates = candicates !! fromJust indexPosition
    where corelations = do
              tmpExponent <- candicates
              let function = fittingFunc tmpExponent
                  fittingData = map function [1..10]
                  actualData = map fromIntegral (fromJust $ combinationCount 10) :: [Double]
                  differences = zipWith (-) fittingData actualData
                  corelation = sum $ map (**2) differences
              return corelation
          bestCorelation = minimum $ map abs corelations
          indexPosition = elemIndex bestCorelation corelations