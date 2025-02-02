{- |
Module                  : Lecture1
Copyright               : (c) 2021-2022 Haskell Beginners 2022 Course
SPDX-License-Identifier : MPL-2.0
Maintainer              : Haskell Beginners 2022 Course <haskell.beginners2022@gmail.com>
Stability               : Stable
Portability             : Portable

Exercises for the Lecture 1 of the Haskell Beginners course.

To complete exercises, you need to complete implementation and add
missing top-level type signatures. You can implement any additional
helper functions. But you can't change the names of the given
functions.

Comments before each function contain explanations and example of
arguments and expected returned values.

It's absolutely okay if you feel that your implementations are not
perfect. You can return to these exercises after future lectures and
improve your solutions if you see any possible improvements.
-}

module Lecture1
    ( makeSnippet
    , sumOfSquares
    , lastDigit
    , minmax
    , subString
    , strSum
    , lowerAndGreater
    ) where

{- | Specify the type signature of the following function. Think about
its behaviour, possible types for the function arguments and write the
type signature explicitly.
-}
makeSnippet :: Int -> [Char] -> [Char]
makeSnippet limit text = take limit ("Description: " ++ text) ++ "..."

{- | Implement a function that takes two numbers and finds sum of
their squares.
>>> sumOfSquares 3 4
25

>>> sumOfSquares (-2) 7
53

Explanation: @sumOfSquares 3 4@ should be equal to @9 + 16@ and this
is 25.
-}
-- DON'T FORGET TO SPECIFY THE TYPE IN HERE
sumOfSquares :: Int -> Int -> Int
sumOfSquares x y = x * x + y * y

{- | Implement a function that returns the last digit of a given number.

>>> lastDigit 42
2
>>> lastDigit (-17)
7

🕯 HINT: use the @mod@ function

-}
-- DON'T FORGET TO SPECIFY THE TYPE IN HERE


lastDigit :: Int -> Int
lastDigit n = abs (n `rem` 10)

{- | Write a function that takes three numbers and returns the
difference between the biggest number and the smallest one.

>>> minmax 7 1 4
6

Explanation: @minmax 7 1 4@ returns 6 because 7 is the biggest number
and 1 is the smallest, and 7 - 1 = 6.

Try to use local variables (either let-in or where) to implement this
function.
-}
minmax :: Int -> Int -> Int -> Int
minmax x y z = max x (max y z) - min x (min y z)

{- | Implement a function that takes a string, start and end positions
and returns a substring of a given string from the start position to
the end (including).

>>> subString 3 7 "Hello, world!"
"lo, w"

>>> subString 10 5 "Some very long String"
""

This function can accept negative start and end position. Negative
start position can be considered as zero (e.g. substring from the
first character) and negative end position should result in an empty
string.
-}


subString :: Int -> Int -> [Char] -> [Char]
subString start end string = 
    let 
        rem_from_the_start = if start < 0
                then 0
                else start;
        go :: Int -> Int -> [Char] -> [Char]
        go remaining_from_the_start remaining_from_the_end str
            | remaining_from_the_start > 0 = go (remaining_from_the_start - 1) remaining_from_the_end (tail str)
            | remaining_from_the_end > 1 = go remaining_from_the_start (remaining_from_the_end - 1) (init str)
            | otherwise = str
    in 
        if (end < 0) || (start > end) then "" else go 
            rem_from_the_start
            (length string - end) 
            string

{- | Write a function that takes a String — space separated numbers,
and finds a sum of the numbers inside this string.

>>> strSum "100    -42  15"
73

The string contains only spaces and/or numbers.
-}

strSum :: [Char] -> Int
strSum str = 
    let
        wordList = words str;
        go :: [[Char]] -> Int
        go list = if null list
            then 0
            else (read (head list) :: Int) + go (tail list)
    in
        go wordList


{- | Write a function that takes a number and a list of numbers and
returns a string, saying how many elements of the list are strictly
greated than the given number and strictly lower.

>>> lowerAndGreater 3 [1 .. 9]
"3 is greater than 2 elements and lower than 6 elements"

Explanation: the list [1 .. 9] contains 9 elements: [1, 2, 3, 4, 5, 6, 7, 8, 9]
The given number 3 is greater than 2 elements (1 and 2)
and lower than 6 elements (4, 5, 6, 7, 8 and 9).

🕯 HINT: Use recursion to implement this function.
-}

lowerAndGreater :: Int -> [Int] -> String
lowerAndGreater n1 list1 = 
    let
        incTupleWithTwoValues :: Int -> (Int, Int) -> (Int, Int)
        incTupleWithTwoValues pos (a, b) = if pos == 0 
            then (a + 1, b)
            else (a, b + 1) 
        go :: Int -> [Int] -> (Int, Int) -> (Int, Int)
        go n list currentState 
            | null list = currentState
            | n > head list = go n (tail list) (incTupleWithTwoValues 0 currentState)
            | n < head list = go n (tail list) (incTupleWithTwoValues 1 currentState)
            | otherwise = go n (tail list) currentState
        getResultString :: Int -> (Int, Int) -> String
        getResultString number (gr, lw) = unwords [show number, "is greater than", show gr, "elements and lower than", show lw, "elements"]
    in
        getResultString n1 (go n1 list1 (0, 0))
