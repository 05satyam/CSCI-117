my_map :: (a -> b) -> [a] -> [b]
my_map _ [] = []
my_map f (x:xs) = f x : my_map f xs

{-
    Examples:
    :> my_map (+2)[1,2,3]
    [3,4,5]
-}


my_all :: (a -> Bool) -> [a] -> Bool
my_all _ []=True
my_all f (x:xs)
      | not (f(x)) = False
      | otherwise = my_all f xs
{-
    Examples:
    :> my_all (<10)[1,2,3,4]
    True
    :> my_all (>10)[1,2,3,4]
    False

    -- in-built all functions
    :> all (<10)[1,2,3,4]
    True
-}


my_any :: (a -> Bool) -> [a] -> Bool
my_any _ []=True
my_any f (x:xs)
      | not (f(x)) = my_any f xs
      | otherwise = True

{-
    Example:
    :> my_any (==10) [1,2,3,10]
    True

    --in-bult any function
    :> any (==10) [1,2,3,10]
    True
-}



my_filter :: (a -> Bool) -> [a] -> [a]
my_filter _ []  = []
my_filter f (x:xs)
        | f x = x : my_filter f xs
        | otherwise = my_filter f xs

{-
    Examples:
    :> my_filter (>3) [1,5,3,2,1,6,4,3,2,1]
    [5,6,4]
    :>
    --inbuilt function output
    :> filter (>3) [1,5,3,2,1,6,4,3,2,1]
    [5,6,4]
-}


my_dropWhile :: (a -> Bool) -> [a] -> [a]
my_dropWhile _ []  = []
my_dropWhile f(x:xs)
           | not(f x) = x : my_dropWhile f xs
           | otherwise = my_dropWhile f xs

{-
    Examples:
    :>
    :> my_dropWhile (<3)[1,2,3,4,5,6]
    [3,4,5,6]
    :>
    --in-built function output
    :> dropWhile (<3)[1,2,3,4,5,6]
    [3,4,5,6]
-}

my_takeWhile :: (a -> Bool) -> [a] -> [a]
my_takeWhile _ []  = []
my_takeWhile f(x:xs)
           | f x = x: my_takeWhile f xs
           | otherwise = my_takeWhile f xs

{-
    Examples:
    :> my_takeWhile(<2)[1,2,3,4,5]
    [1]
    :>
    --in-built function output
    :> takeWhile(<2)[1,2,3,4,5]
    [1]
-}

my_break :: (a -> Bool) -> [a] -> ([a], [a])
my_break f []=([],[])
my_break f (x:xs) = let (ys,zs) = my_break f xs
                    in if(f x)
                       then (x:ys, zs)
                       else (ys, x:xs)


{-
    Examples:
    :> my_break (<3)[1,2,3,4,5]

    :> my_break (<0)[1,2,3,4,5]
    ([],[1,2,3,4,5])
-}

-- Implement the Prelude functions and, or, concat using foldr

my_and :: [Bool] -> Bool
my_and = foldr (&&) True
{-
    Examples:
    :> my_and [True,False]
    False
    :> my_and [True,True]
    True
-}


my_or :: [Bool] -> Bool
my_or = foldr (||) False

{-
    Exxamples:

    :> my_or [True,True]
    True
    :> my_or [True,False]
    True
    :> my_or [False,False]
    False
-}

my_concat :: [[a]] -> [a]
my_concat = foldr (++) []

{-
    Examples:
    :> my_concat [["abs"] , ["cdf"]]
    ["abs","cdf"]
-}


-- Implement the Prelude functions sum, product, reverse using foldl

my_sum :: Num a => [a] -> a
my_sum = foldl (+) 0
{-
    Example:

    :> my_sum [1,2,3]
    6
    :> my_sum [1,2,3, -1]
    5
-}


my_product :: Num a => [a] -> a
my_product = foldl (*) 1
{-
    Examples:
    :> my_product [1,2,3, -1]
    -6
    :> my_product [1,2,3]
    6
-}

my_reverse :: [a] -> [a]
my_reverse = foldl (flip (:)) []
{-
    Examples:
    :> my_reverse [1,2,3]
    [3,2,1]
    :>
    :> my_reverse "abc"
    "cba"
-}
