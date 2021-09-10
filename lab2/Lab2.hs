-- PART 1: Basic structural recursion --------------------------------------------------

-- 1. Merge sort

deal :: [a] -> ([a],[a])
deal [] = ([],[])
deal (x:xs) = let (ys,zs) = deal xs
              in if(length xs)`mod` 2 ==0
              then (x:ys,zs)
              else (x:zs,ys)

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x:(merge xs (y:ys))

  | x > y  = y:(merge (x:xs) ys)

ms :: Ord a => [a] -> [a]
ms [] = []
ms [x] = [x]
ms xs = merge (ms firstFew) (ms lastFew)
    where firstFew = fst(deal xs)
          lastFew = snd(deal xs)



-- 2. A backward list data structure

data BList a = Nil | Snoc (BList a) a deriving (Show,Eq)

-- Add an element to the beginning of a BList, like (:) does
cons :: a -> BList a -> BList a
cons a Nil = Snoc Nil a
cons a (Snoc xs x) = Snoc (cons a xs) x
{-
    E
    xample:
    :> l= Snoc (Snoc (Snoc Nil 1) 2) 3
    :> cons 5 l
    Snoc (Snoc (Snoc (Snoc Nil 5) 1) 2) 3


    :> t = Snoc (Snoc (Snoc Nil 1) 2) 3
    :>
    :>
    :> res = cons 10 t
    :>
    :> res
    Snoc (Snoc (Snoc (Snoc Nil 10) 1) 2) 3
-}

-- Convert a usual list into a BList (hint: use cons in the recursive case)
toBList :: [a] -> BList a
toBList [] = Nil

toBlist(x : xs) = cons x (toBList xs)

{-
  Example:
  *Main> toBList [1,2,3,4]
  Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4
-}


-- Add an element to the end of an ordinary list
snoc :: [a] -> a -> [a]
snoc [] a = [a]
snoc (x:xs) a = x: snoc xs a
{-
    *Main> l=[1,2,3]
    *Main> l
    [1,2,3]
    *Main> snoc l 1
    [1,2,3,1]

    :> l=[1,2,3]
    :> snoc l 10
    [1,2,3,10]
-}

-- Convert a BList into an ordinary list (hint: use snoc in the recursive case)
fromBList:: BList a -> [a]
fromBList Nil = []
fromBList (Snoc xs x) = snoc  (fromBList xs)  x

{-
    Example
    :> l= Snoc (Snoc (Snoc Nil 1) 2) 3
    :> l
    Snoc (Snoc (Snoc Nil 1) 2) 3
    :>
    :> fromBList l
    [1,2,3]
-}

-- 3. A binary tree data structure


data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

-- Count number of Empty's in the tree
num_empties :: Tree a -> Int
num_empties (Empty)=1
num_empties (Node a left right) =  num_empties left + num_empties right
{-
    Examples:
    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :> num_empties tree1
    4
-}


-- Count number of Node's in the tree
num_nodes :: Tree a -> Int
num_nodes (Empty) = 0
num_nodes (Node a left right) = 1 + num_nodes left + num_nodes right

{-
    examples:

    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :> tree1
    Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :>
    :>
    :> num_nodes tree1
    3
-}


-- Insert a new node in the leftmost spot in the tree
insert_left ::(Ord a)=> a -> Tree a -> Tree a
insert_left x Empty = Node x Empty Empty
insert_left x (Node a left right)
    | (x==a) = Node x left right
    | (x < a) = Node a (insert_left x left) right
    | (x > a) = Node a left (insert_left x right)


{-
    Examples:
    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :>
    :> t
    Node 5 (Node 3 Empty (Node 4 Empty Empty)) (Node 10 Empty Empty)
    :>

-}


-- Insert a new node in the rightmost spot in the tree
insert_right ::(Ord a)=> a -> Tree a -> Tree a
insert_right x Empty = Node x Empty Empty
insert_right x (Node a left right)
    | (x==a) = Node x left right
    | (x > a) = Node a left (insert_right x right)
    | (x < a) = Node a (insert_right
     x left) right


{-
    Examples:
    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :> tree2 = insert_right 10 tree1
    :> tree2
    Node 5 (Node 3 Empty (Node 4 Empty Empty)) (Node 10 Empty Empty)
    :>
-}


-- Add up all the node values in a tree of numbers
sum_nodes :: Num a => Tree a -> a
sum_nodes Empty = 0
sum_nodes (Node x left right) = x + (sum_nodes left) + (sum_nodes right)

{-
    Examples
    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :> sum_nodes tree1
    12
-}


-- Produce a list of the node values in the tree via an inorder traversal
-- Feel free to use concatenation (++)
inorder :: (Ord a) => Tree a -> [a]
inorder Empty = []
inorder (Node v t1 t2) = (inorder t1) ++ [v] ++ (inorder t2)

{-
    Examples:
    :>
    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :> inorder tree1
    [3,4,5]
-}

-- 4. A different, leaf-based tree data structure


data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show

-- Count the number of elements in the tree (leaf or node)

num_elts :: Tree2 a -> Int
num_elts (Leaf n) =  1
num_elts (Node2 a left right) = 1 + num_elts left + num_elts right

{-
    Examples:
    :> tree12 = Node2 5 (Node2 3 (Leaf 5) (Node2 4 (Leaf 3) (Leaf 2))) (Leaf 1)
    :>
    :>
    :> tree12
    Node2 5 (Node2 3 (Leaf 5) (Node2 4 (Leaf 3) (Leaf 2))) (Leaf 1)
-}


-- Add up all the elements in a tree of numbers
sum_nodes2 :: Num a => Tree2 a -> a
sum_nodes2 (Leaf n )= n
sum_nodes2 (Node2 x left right) = x + (sum_nodes2 left) + (sum_nodes2 right)

{-
    Examples:
    :> tree12 = Node2 5 (Node2 3 (Leaf 5) (Node2 4 (Leaf 3) (Leaf 2))) (Leaf 1)
    :> sum_nodes2 tree12
    23
-}

-- Produce a list of the elements in the tree via an inorder traversal
-- Again, feel free to use concatenation (++)
inorder2 :: (Ord a) => Tree2 a -> [a]
inorder2 (Leaf n)= [n]
inorder2 (Node2 v t1 t2) = (inorder2 t1) ++ [v] ++ (inorder2 t2)

{-
    Examples:
    :> tree12 = Node2 5 (Node2 3 (Leaf 5) (Node2 4 (Leaf 3) (Leaf 2))) (Leaf 1)
    :> inorder2 tree12
    [5,3,3,4,2,5,1]
-}

-- END of PART 1 -----------------------------------------------------------------------

--
--
--
--
--
--
--

-- PART 2: Iteration and Accumulators---------------------------------------------------
toBList' :: [a] -> BList a
toBList' t= toBList_it t where
      toBList_it :: [a] -> BList a
      toBList_it [] = Nil
      toBlist(x : xs) = cons x (toBList_it xs)
{-
      Example:
      *Main> toBList' [1,2,3,4]
      Snoc (Snoc (Snoc (Snoc Nil 1) 2) 3) 4
-}

fromBList' :: BList a -> [a]
fromBList' t= fromBList_it t where
          fromBList_it :: BList a -> [a]
          fromBList_it Nil = []
          fromBList_it(Snoc xs x) = snoc  (fromBList_it xs)  x

    {-
      Example
      :> l= Snoc (Snoc (Snoc Nil 1) 2) 3
      :> fromBList' l
      [1,2,3]
    -}


num_empties' :: Num a => Tree a -> a
num_empties' t= num_empties_it [t] 1 where
    num_empties_it :: Num a=> [Tree a] -> a -> a
    num_empties_it [] a =a
    num_empties_it (Empty:ts) a = num_empties_it ts a
    num_empties_it (Node n t1 t2:ts) a= num_empties_it (t1:t2:ts) (1+a)
{-
  Examples:
  :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
  :> num_empties' tree1
  4
-}


num_nodes' :: Num a => Tree a -> a
num_nodes' t = num_nodes_it [t] 0 where
    num_nodes_it :: Num a => [Tree a] -> a -> a
    num_nodes_it [] a = a
    num_nodes_it (Empty:ts) a = num_nodes_it ts a
    num_nodes_it (Node n t1 t2:ts) a = num_nodes_it (t1:t2:ts) (1+a)

{-
    Examples:
    :> tree1 = Node 5 (Node 3 Empty (Node 4 Empty Empty)) Empty
    :> num_nodes' tree1
    3
-}


sum_nodes2' :: Num a => Tree2 a -> a
sum_nodes2' t = sum_nodes2_it [t] 0 where
    sum_nodes2_it :: Num a => [Tree2 a] -> a -> a
    sum_nodes2_it [] a=a
    sum_nodes2_it (Leaf n:ts) a = sum_nodes2_it ts a
    sum_nodes2_it (Node2 n t1 t2:ts) a = sum_nodes2_it (t1:t2:ts) (n+a)

{-
  Examples:
  Node2 5 (Node2 3 (Leaf 5) (Node2 4 (Leaf 3) (Leaf 2))) (Leaf 1)
  :>
  :>
  :> sum_nodes2' tree12
  12
-}

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
inorder2' :: (Ord a) => Tree2 a -> [a]
inorder2' tree' = inorder_it tree' [] where
    inorder_it :: Tree2 a -> [a] -> [a]
    inorder_it (Leaf a) = (a :)
    inorder_it (Node2 a left right) = (inorder_it left) . (a :) . (inorder_it right)
{-
    Example:
    :> tree12 = Node2 5 (Node2 3 (Leaf 5) (Node2 4 (Leaf 3) (Leaf 2))) (Leaf 1)
    :>
    :>
    :> inorder2' tree12
    [5,3,3,4,2,5,1]
-}
-- END of PART 2 -----------------------------------------------------------------------

--
--
--
--
--
--
--

-- PART 3: Higher-order functions--------------------------------------------------------

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

-- END of PART 3------------------------------------------------------------------------
