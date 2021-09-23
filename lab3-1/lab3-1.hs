-- CSci 117, Lab 3:  ADTs and Type Classes

import Data.List
import Queue1
import Fraction


---------------- Part 1: Queue client

-- add a list of elements, in order, into a queue
adds :: [a] -> Queue a -> Queue a
adds [] q = q
adds (x:xs) q = adds xs (addq x q)
{-
    Examples:
    :> let q=mtq
    :> q
    Queue1 []
    :>
    :>
    :> let q1= adds [1] q
    :> q1
    Queue1 [1]
    :>
    :>
    :> let q2= adds [2,3] q1
    :> q2
    Queue1 [3,2,1]
-}


-- remove all elements of the queue, putting them, in order, into a list
rems :: Queue a -> [a]
rems q = if ismt q then []
        else let (x,q1) = remq q
             in x :rems q1
{-
  Examples:
  :> let q= mtq
  :>
  :> let q1 = adds [1,2,3,4,5] q
  :> q1
  Queue1 [5,4,3,2,1]
  :> rems q1
  [1,2,3,4,5]
-}

-- test whether adding a given list of elements to an initially empty queue
-- and then removing them all produces the same list (FIFO). Should return True.
testq :: Eq a => [a] -> Bool
testq xs = xs == rems (adds xs mtq)
{-
    Example:
    Queue1 [5,4,3,2,1]
    :> testq [1,2,3,4,5]
    True
-}


---------------- Part 2: Using typeclass instances for fractions-----------------


-- Calculate the average of a list of fractions
-- Give the error "Empty average" if xs is empty
--
--
average :: [Fraction] -> Fraction
average [] = 0
average (x:xs) = Just(sumInst x (average xs))



list1 = [fraction n (n+1) | n <- [1..20]]
list2 = [fraction 1 n | n <- [1..20]]
--list3 = zipWith (+) (init list1) (init list2)



-- Construct a fraction, producing an error if it fails

fraction :: Integer -> Integer -> Fraction
fraction a b = case frac a b of
             Nothing -> error "Illegal fraction"
             Just fr -> fr

{-
  Examples:
  :> f1 = fraction 1 2
  :>
  :> f2 = fraction 3 4
  :>
  :> f1
  1 / 2
  :> f2
  3 / 4

-}


product :: Fraction ->  Fraction -> Maybe Fraction
product a b = mult a b
{-
    Example:
    :> f1 = fraction 1 2
    :>
    :> f2 = fraction 3 4
    :>
    :> f1
    1 / 2
    :> f2
    3 / 4
    :>
    :>
    :> product f1 f2
    Just 3 / 8

-}

--sum of fractions
newSum :: Fraction -> Fraction -> Maybe Fraction
newSum a b = sumInst a b
{-
    Example:

    :> f1 = fraction 3 4
    :> f2 = fraction 5 6
    :>
    :> f1
    3 / 4
    :> f2
    5 / 6
    :> Main.sum f1 f2
    Just 19 / 12
-}

--ord Fractions
{-newOrd :: Fraction -> Fraction -> Maybe Fraction
newOrd a b = Ord a b
-}

{-
    examples of Ord:

    :> f1 = fraction 3 2
    :> f1
    3 / 2
    :>
    :>
    :> f2 = fraction 1 2
    :> f2
    1 / 2
    :>
    :>
    :>
    :> compare f1 f2
    GT
    :> max f1 f2
    3 / 2
    :> min f1 f2
    1 / 2
-}
