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

fromBList' :: BList a -> [a]
fromBList' t= fromBList_it t where
        fromBList_it :: BL
        ist a -> [a]
        fromBList_it Nil = []
        fromBList_it(Snoc xs x) = snoc  (fromBList_it xs)  x

{-
  Example
  :> l= Snoc (Snoc (Snoc Nil 1) 2) 3
  :> fromBList' l
  [1,2,3]
-}
