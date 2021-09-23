module Fraction (Fraction, frac, mult, sumInst) where

-- Fraction type. ADT maintains the INVARIANT that every fraction Frac n m
-- satisfies m > 0 and gcd n m == 1. For fractions satisfying this invariant
-- equality is the same as literal equality (hence "deriving Eq")

data Fraction = Frac Integer Integer deriving(Eq)



-- Public constructor: take two integers, n and m, and construct a fraction
-- representing n/m that satisfies the invariant, if possible
frac :: Integer -> Integer ->Maybe Fraction
frac a b | b == 0    = Nothing
             | otherwise = Just(simplify $ Frac a b)


simplify :: Fraction -> Fraction
simplify (Frac a b) = Frac a' b'
          where d = gcd a b
                a' = a `div` d
                b' = b `div` d


-- Show instance that outputs Frac n m as n/m
instance Show Fraction where
  show (Frac a b) = (show a) ++ " / " ++ (show b)


-- Ord instance for Fraction
instance Ord Fraction where
  compare (Frac a b) (Frac c d) = compare (a `quot` b) (c `quot` d)
  (<)  frac1    = (==) LT . compare frac1
  (>)  frac1    = (==) GT . compare frac1
  (>=) frac1    = not . (<) frac1
  (<=) frac1    = not . (>) frac1
  max  frac1 frac1' = if frac1 < frac1' then frac1' else frac1
  min  frac1 frac1' = if frac1 < frac1' then frac1 else frac1'

-- Num instance for Fraction


--Fraction Product
mult :: Fraction -> Fraction -> Maybe Fraction
Frac a b `mult` Frac c d = frac (a * c) (b * d)


--Fraction sum

sumInst :: Fraction -> Fraction -> Maybe Fraction
Frac a b `sumInst` Frac c d = frac (a * d + b * c) (b * d)



{-
sumFracList :: [Fraction] -> Fraction
sumFracList [] = 0
sumFracList (x:xs) = (sumInst x (Frac sumFracList xs))
-}
