-- 3. A binary tree data structure



data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)

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

--data Tree2 a = Leaf a | Node2 a (Tree2 a) (Tree2 a) deriving Show
--data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)
-- Convert a Tree2 into an equivalent Tree1 (with the same elements)
--conv21 :: Tree2 a -> Tree a
--conv21 (Empty)= []
--conv21 (Node2 x left right) = [x] ++ conv21(left) ++ conv21(right)

conv21 :: (Tree2 a) -> (Tree a)
conv21 (Leaf n)=(Empty)
conv21 (Node tleft y tright) = conv21 Node2





--Part 2--------------------------


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

-- Use the technique once more to rewrite inorder2 so it avoids doing any
-- concatenations, using only (:).
-- Hint 1: (:) produces lists from back to front, so you should do the same.
-- Hint 2: You may need to get creative with your lists of trees to get the
-- right output.


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
