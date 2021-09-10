--NOTE: Symbole ":>  "is my ghci prompt

--rem, mod-----------------------------------------------------------------------

{-
rem :: Integral a => a -> a -> a
   ---> returns reminder of integer division of the arguments
   ---> type info:
          :> :t 4`rem`2
          4`mod`2 :: Integral a => a


mod :: Integral a => a -> a -> a
   ---> returns modulo of integer arguments
   ---> type info:
          :> :t 3`mod`2
          3`mod`2 :: Integral a => a

Q. Difference between mod and rem?
A. Both are part of Integer class but `rem` is used to get the integer division of the arguments however `mod` is used to get the modulo of integer arguments.

Examples:

rem::
    :> 5 `rem` 3
    2

    :> 5 `rem` (-3)
    2

    :> (-5) `rem` 3
    -2

    :> (-5) `rem` (-3)
    -2
    :>
    :> 33 `rem` 2
    1
    :> 40 `rem` 10
    0

    Error case: as rem supports only integer division so below error will come when
                other than integer arguments are use.
    Eg:
    :> 'ab' `rem` 'cd'

    <interactive>:241:1: error:
      • Syntax error on 'ab'
        Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
      • In the Template Haskell quotation 'ab'


mod::
    :> 3 `mod` 2
    1
    :>
    :> 3 `mod` (-1)
    0
    :>
    :> (-3) `mod` 1
    0


    Error

    Case1: if we remove quots from mod operator
    :> 10 mod 10

    <interactive>:255:1: error:
      • Non type-variable argument
          in the constraint: Num ((a -> a -> a) -> t1 -> t2)
        (Use FlexibleContexts to permit this)
      • When checking the inferred type
          it :: forall a t1 t2.
                (Integral a, Num t1, Num ((a -> a -> a) -> t1 -> t2)) =>
                t2

     Case2: Strings not supported

     :> 'ab' `mod` 'ab'

<interactive>:260:1: error:
    • Syntax error on 'ab'
      Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
    • In the Template Haskell quotation 'ab'
-}


--quot, div---------------
{-
  quot :: Integral a => a -> a -> a
       ---> it is an integer division where we  divides the first argument by the second one discarding the remainder
       ---> type info:
             :> :type 3 `quot` 12
             3 `quot` 12 :: Integral a => a

   div :: Integral a => a -> a -> a
      ---> It returns how many times the first argument can be divided by the second one
      ---> type info:
            :> :type 6 `div` 1
            6 `div` 1 :: Integral a => a

  Q. Difference between quot and div?
  A. Both are part of Integer class and both are giving the same value below are the example for the same

Examples:

  quot ::
      :>
    :> 33 `quot` 12
    2
    :>
    :> 33 `quot` (-12)
    -2
    :> (-33) `quot` (12)
    -2
    :>
    :> (-33) `quot` (112)
    0
    :> (-33) `quot` (-12)
    2
    :>

    Error Case: Only integer arguments are supported
    :> 'a' `quot` 'b'

    <interactive>:289:1: error:
    • No instance for (Integral Char) arising from a use of ‘quot’
    • In the expression: 'a' `quot` 'b'
      In an equation for ‘it’: it = 'a' `quot` 'b'


  div ::
    :> 6 `div` (-2)
    -3
    :> (-6) `div` (-2)
    3
    :> (-6) `div` (2)
    -3
    :>
    :> (100) `div` (10)
    10
    :> (100000) `div` (200)
    500
    :>

    Error case: Only integer arguments are supported
    :> ('cd') `div` ('ab')

    <interactive>:305:2: error:
    • Syntax error on 'cd'
      Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
    • In the Template Haskell quotation 'cd'

-}


--quotRem, divMod----------------------------------------------------------------
{-
  quotRem :: Integral a => a -> Rational
          ---> It returns a tuple: (result of integer division, reminder)
          ---> type info:
                :> :t quotRem 4 3
                quotRem 4 3 :: Integral a => (a, a)

  divMod :: Integral a => a -> a -> (a,a)
         ---> the function returns a tuple containing the result of integral division and modulo
         ---> type info:
              :> :t divMod 3 5
              divMod 3 5 :: Integral a => (a, a)

    Examples:

    divMod ::
          :> divMod (-130) (-10)
          (13,0)

          :> divMod (120) (-10)
          (-12,0)

          :> divMod 13 (-5)
          (-3,-2)

          :> divMod (-13) 5
          (-3,2)
          :>
          :> divMod (-13) (-5)
          (2,-3)

          Error case: only integer supported
          :> divMod ('ab') ('cd')
          <interactive>:328:9: error:
          • Syntax error on 'ab'
            Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
          • In the Template Haskell quotation 'ab'

  quotRem ::
          :> quotRem 22 8
          (2,6)
          :>
          :> quotRem 12 4
          (3,0)
          :>
          :> quotRem (-12) 6
          (-2,0)
          :>
          :>
          :> quotRem (-12) (-6)
          (2,0)
          :>
          :> quotRem (12) (-6)
          (-2,0)

          Error case: only integer supported

          :> quotRem ('cd') ('ab')

          <interactive>:350:10: error:
              • Syntax error on 'cd'
                Perhaps you intended to use TemplateHaskell or TemplateHaskellQuotes
              • In the Template Haskell quotation 'cd'
-}

--zip----------------------------------------------------------------------------
{-

  zip :: [a] -> [b] -> [(a,b)]
      ---> It makes a list of tuples, each tuple containing elements of both lists occuring at the same position
      ---> type info:
            :> :t zip [1,2,3] [9,8,7]
            zip [1,2,3] [9,8,7] :: (Num a, Num b) => [(a, b)]

      Examples:
        :> zip [1,2,3] [9,8,7]
        [(1,9),(2,8),(3,7)]
        :>

        :> zip [1,2,3,10000] [9,8,7,10000]
        [(1,9),(2,8),(3,7),(10000,10000)]

        :> zip [1,2,3,10000] [0001, 0010, 0110, 0100]
        [(1,1),(2,10),(3,110),(10000,100)]

        :> zip [1,2,3,10000] [0001, 0010, 0110]
        [(1,1),(2,10),(3,110)]

        :> zip [1,-2,3,-10000] [0001, 0010, -0110]
        [(1,1),(-2,10),(3,-110)]

-}

--splitAt-----------------------------------------------------------------------
{-
  splitAt :: Int -> [a] -> ([a],[a])
          ---> this operator will split the list into two and gives you two list
          ---> type info:
                :> :t splitAt 5 [1,2,3,4,5,6,7,8,9,10]
                splitAt 5 [1,2,3,4,5,6,7,8,9,10] :: Num a => ([a], [a])

          Examples:

          :> splitAt 5 [1,2,3,4,5,6,7,8,9,10]
          ([1,2,3,4,5],[6,7,8,9,10])

          :> splitAt 5 [-1,2,3,-4,5,6,-7,8,9,-10]
          ([-1,2,3,-4,5],[6,-7,8,9,-10])

          :> splitAt 5 [-1]
          ([-1],[])

          :> splitAt 5 []
          ([],[])


          Error case: only integers are allowed

          :> splitAt 5 ['a' 'b']

          <interactive>:397:12: error:
              • Couldn't match expected type ‘Char -> a’ with actual type ‘Char’
              • The function ‘'a'’ is applied to one argument,
                but its type ‘Char’ has none
                In the expression: 'a' 'b'
                In the second argument of ‘splitAt’, namely ‘['a' 'b']’
              • Relevant bindings include
                  it :: ([a], [a]) (bound at <interactive>:397:1)

-}


--snd---------------------------------------------------------------------------
{-

    snd :: (a,b) -> b
        ---> this operator will return the second element from tupple
        ---> type info:
                :> :t snd(1,2)
                snd(1,2) :: Num b => b

                :> :t snd('a', 'b')
                snd('a', 'b') :: Char

        Example:

        :> snd ('a', 'b')
        'b'

        :> snd (1,2)
        2

        :> snd(-1,-2)
        -2

        :> snd(-1,200000)
        200000

        :> snd("123", "23445")
        "23445"


-}


--reverse-----------------------------------------------------------------------
{-
  reverse :: [a] -> [a]
          ---> it creates a new string from the original one with items in the reverse order
          ---> type info:
                    :> :t reverse("abc")
                    reverse("abc") :: [Char]


          Examples
          :> reverse("abc")
          "cba"

          :> reverse("123")
          "321"


          :> reverse("-1123")
          "3211-"

          :> reverse("100100")
          "001001"
          :> reverse("haskelleksah")
          "haskelleksah"

-}


--replicate----------------------------------------------------------------------
{-
  replicate :: 	Int -> a -> [a]
            ---> it creates a list of length given by the first variable and the items having value of the second variable
            --->type info:
                  :> :t replicate 3 5
                  replicate 3 5 :: Num a => [a]

          Example:
          :> replicate 3 5
          [5,5,5]

          :> replicate 3 "abc"
          ["abc","abc","abc"]

          :> replicate 3 "101"
          ["101","101","101"]

          :> replicate 100 "-1"
          ["-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1","-1"]

          :> replicate 31 "117"
          ["117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117","117"]

-}


--repeat-------------------------------------------------------------------------
{-
  repeat :: a -> [a]
         ---> it creates an infinite list where all items are the first argument but we can put a limit to the list too
         --->type info:
                 :> :t repeat 4
                  repeat 4 :: Num a => [a]

         Example:

          :> repeat 4
          [4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,............................................... to infinit

          :> repeat -9
          [-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,-9,............... to infite

          :> repeat 'A'
          "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA.......................to infite
-}

--odd----------------------------------------------------------------------------
{-
  odd :: Integral a => a -> Bool
      ---> it returns true if argument is odd
      ---> type info:
              :> :t odd 3
              odd 3 :: Bool

      Example:


      :> odd 3
      True
      :> odd 5
      True
      :> odd 6
      False
      :> odd 10
      False
      :> odd 1000
      False
      :> odd 1001
      True

      Error case: only positive number supported
      :> odd -1001

      <interactive>:17:1: error:
          • Non type-variable argument in the constraint: Num (a -> Bool)
            (Use FlexibleContexts to permit this)
          • When checking the inferred type
              it :: forall a. (Integral a, Num (a -> Bool)) => a -> Bool

-}

--null---------------------------------------------------------------------------
{-
  null :: [a] -> Bool
      ---> it returns true is list is empty otherwise False
      ---> type info:
                :> :t null[]
                null[] :: Bool

      Examples:

            :> null [1]
            False
            :>
            :> null [1,2]
            False
            :>
            :>
            :> null []
            True
            :> null [[]]
            False
            :> null [[[]]]
            False
            :> null []
            True

-}


--length-------------------------------------------------------------------------
{-
    length :: [a] -> Int
          ---> returns the number of elements in the list
          ---> type info:
                  :> :t length [1]
                  length [1] :: Int

          Examples:

          :> length [1]
          1
          :> length [1,2,3,4]
          4
          :> length [1,-2,3,-4]
          4
          :>
          :> length [[]]
          1
          :> length [[[]]]
          1
          :>
          :> length [[[[-1]]]]
          1
-}


--lcm----------------------------------------------------------------------------
{-
  lcm :: Integral a => a -> a -> a
      ---> it returns the lowest common multiple of a tuple
      ---> type info:
              :> :t lcm 4 5
              lcm 4 5 :: Integral a => a

      Examples:

      :> lcm 4 5
      20
      :> lcm 4 (-5)
      20
      :>
      :> lcm (-4) (-5)
      20
      :>
      :>
      :> lcm (-4) (5)
      20
      :> lcm (0) (0)
      0
      :> lcm (-4) (50)
      100
-}

--last---------------------------------------------------------------------------
{-
  last :: [a] -> a
      ---> it returns the last item of lists
      ---> type info:
              :> :t last[1,2,3]
              last[1,2,3] :: Num a => a

      Examples:
        :> last[1,2,3]
        3
        :> last[1,2,3,5,6,7,-1]
        -1
        :> last[[]]
        []
        :> last["abc", "cde"]
        "cde"
        :>
        :>
        :> last "abc"
        'c'
-}


--init---------------------------------------------------------------------------
{-
  init :: [a] -> [a]
      ---> it accept a list and return list without last elements
      ---> type info:
                :> :t init[1,2,3]
                init[1,2,3] :: Num a => [a]

                :> :t init "abc"
                init "abc" :: [Char]

      Examples:

      :> init[1,2,3]
      [1,2]
      :>
      :>
      :> init[1]
      []
      :> init[-1]
      []
      :> init[-1,-2,03]
      [-1,-2]
      :> init["abc", "cde"]
      ["abc"]
      :> init "abc"
      "ab"

-}



--id-----------------------------------------------------------------------------
{-
  id :: a -> a
    ---> its an identity function
    ---> type info:
            :> :t id 3
            id 3 :: Num a => a
            :> :t id "a"
            id "a" :: [Char]

      Examples:

      :>  id "a"
      "a"
      :>
      :>  id "123"
      "123"
      :>  id "abc"
      "abc"
      :>  id ""
      ""
      :> id (-300)
      -300

-}

--head----------------------------------------------------------------------------
{-
  head :: [a] -> a
      ---> returns the head element of list
      ---> type info:
              :> :t head [1,2,3]
              head [1,2,3] :: Num a => a

      Examples:

        :> head [1,2,3]
        1
        :> head []
        *** Exception: Prelude.head: empty list
        :> head [[]]
        []
        :>
        :>
        :> head ["abc", "bcd"]
        "abc"
        :>
        :>
        :> head [-1,-2,-3,-4]
        -1
-}

--gcd----------------------------------------------------------------------------
{-
    gcd :: Integral a => a -> a -> a
        ---> it returns the gcd of two arguments
        ---> type info:
                :> :t gcd 4 5
                gcd 4 5 :: Integral a => a

        Examples:

        :> gcd 4 5
        1
        :> gcd 4 (-5)
        1
        :> gcd (-40) (-5)
        5
        :> gcd (040) (5)
        5
        :> gcd (040) (100)
        20
        :> gcd (7) (3)
        1

-}


--fst----------------------------------------------------------------------------
{-
    fst :: (a,b) -> a
        ---> it returns the first element of tuple
        ---> type info:
                :> :t fst (3 4)
                fst (3 4) :: (Num t, Num (t -> (a, b))) => a


        Examples:

          :> fst(3, 4)
          3
          :> fst(-101, 4)
          -101
          :> fst(101, -9)
          101
          :> fst("abc", "cde")
          "abc"
          :>
          :> fst("", "cde")
          ""
-}

--even---------------------------------------------------------------------------
{-
    even :: Integral a => a -> Bool
        ---> it returns true if argument is divisible by 2 otherwise False
        ---> type info:
                  :> :t even 2
                  even 2 :: Bool

        Examples:
          :> even 2
          True
          :> even (-20)
          True
          :> even (-21)
          False
          :> even (21)
          False
          :> even (31)
          False
          :> even (-32)
          True
-}

--elem---------------------------------------------------------------------------
{-
    elem :: Eq a => a -> [a] -> Bool
        ---> returns true if list contains any element equal to first argument

        ---> type info:
                :> :t elem 1 [1,2,3,1]
                elem 1 [1,2,3,1] :: Bool

        Examples:
            :> elem (-1) [-1 ,2 ,3]
            True
            :> elem 1 [-123]
            False
            :> elem 'a' "aaam"
            True
            :>
            :> elem '1' "1234"
            True
-}

--drop, take---------------------------------------------------------------------
{-
    drop :: Int -> [a] -> [a]
        ---> by using this operator first n elements are dropped from the list, where n is the fist argument of the function calling
        ---> type info:
                  :> :t drop 5 [1,2,3,4,5]
                  drop 5 [1,2,3,4,5] :: Num a => [a]

            Examples:
              :> drop 5 [1,2,3,4,5]
              []
              :>
              :>
              :> drop 5 [1,2,3,4,5, -1]
              [-1]
              :> drop 2 ["abc", "cde", "edf"]
              ["edf"]
              :> drop 4 ["abc", "cde", "edf"]
              []
              :> drop 5 ["abc", "cde", "edf"]
              []



    take :: Int -> [a] -> [a]
        ---> it creates a new list and the first argument determines, how many items should be taken from the list passed as the second argument
        ---> type info:
                  :> :t  take 5 [1,2,3,4,5,6,7]
                  take 5 [1,2,3,4,5,6,7] :: Num a => [a]
          Examples:
            :> take 5 [1,2,3,4,5,6,7]
            [1,2,3,4,5]
            :>
            :> take 5 [1,2,3,4]
            [1,2,3,4]
            :> take 5 [1,2,3]
            [1,2,3]
            :> take 1["abc", "cdr"]
            ["abc"]
            :>
            :> take 1[[[]]]
            [[[]]]
            :>
            :>
            :> take 1[[]]
            [[]]
-}


--cycle--------------------------------------------------------------------------
{-
  cycle :: 	[a] -> [a]
        ---> it create a circular list from the finite list given in arguments
        ---> type info :
                :> :t cycle [1,2,3,4,4]
                cycle [1,2,3,4,4] :: Num a => [a]

        Examples:

        :> cycle [1,2,3,4,4]
        [1,2,3,4,4,1,2,3,4,4,1,2,3,4,4,1,2,3,4.................. to infinite

        :> cycle [-1, 2, -1]
        [-1,2,-1,-1,2,-1,-1,2,-1,-1,2,-1,......................to infinite

        :> cycle []
        *** Exception: Prelude.cycle: empty list
-}

--const--------------------------------------------------------------------------
{-
  const :: a -> b -> a
        ---> this is a constant function
        ---> type info:
                  :> :t const 12 3
                  const 12 3 :: Num a => a

        Examples:
          :> const 11 2
          11
          :> const (-11) 2
          -11
          :> const 12 (3/0)
          12
          :> const 12 3
          12
-}

--concat-------------------------------------------------------------------------
{-
  concat :: [[a]] -> [a]
        ----> it accepts the list of lists and return by concatinating them
        ----> type info:
                  :> :t concat [[1,2,3], [1,2,3]]
                  concat [[1,2,3], [1,2,3]] :: Num a => [a]

          Examples:
          :> concat [[1,2,3], [1,2,3]]
          [1,2,3,1,2,3]
          :> concat [[], []]
          []
          :> concat [[], [1]]
          [1]
          :> concat [[-1], [1]]
          [-1,1]

        Error case: only similar data type can be concatinated
        :> concat [[-1], ["abc"]]

        <interactive>:35:10: error:
            • No instance for (Num [Char])
                arising from a use of syntactic negation
            • In the expression: - 1
              In the expression: [- 1]
              In the first argument of ‘concat’, namely ‘[[- 1], ["abc"]]’
-}

-- ^ ----------------------------------------------------------------------------
{-
    ^ :: this is a power operator used to calculate (a power b) where a and b are integer
    ---- type info:
              :> :t 3 ^ 2
              3 ^ 2 :: Num a => a

      Examples:

      :> 3 ^ 2
      9
      :> 3 ^ (-2)
      *** Exception: Negative exponent
      :> (-3) ^ (2)
      9
      :> (-3) ^ (1)
      -3
      :> (-30) ^ (10)
      590490000000000


-}


--max, min-----------------------------------------------------------------------
{-
    max :: Ord a => a -> a -> a
        ---> it returns the largest of the two arguments
        ---> type info:
                :> :t max 2 4
                max 2 4 :: (Ord a, Num a) => a

        Examples:

          :> max 2 4
          4
          :> max 2 (-1)
          2
          :> max (-12) (-10)
          -10
          :> max (-8) (-10)
          -8
          :> max (0) (0)
          0
          :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
          :> max Red Orange
          Orange
          :> max Violet Green
          Violet

    min :: Ord a => a -> a -> a
        ---> it returns the minimum of two arguments
        ---> type info:
                :> :t min 4 5
                min 4 5 :: (Ord a, Num a) => a

        Examples:
        :> min 4 5
        4
        :> min 4 (-5)
        -5
        :> min (-4) (-5)
        -5
        :> min (0) (0)
        0
        :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
        :> min Violet Green


-}


-- <, > -------------------------------------------------------------------------
{-
    < :: Ord a => a -> a -> Bool
      ---> this is less than operator and returns bool value either true or false
      ---> type info:
                :> :t 3 <4
                3 <4 :: Bool

          Examples:
          :> 3 <4
          True
          :> 3 <(-40)
          False
          :> (-30) <(-40)
          False
          :> (0) <(0)
          False
          :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
          :> Red<Violet
          True
          :> Orange< Green
          True

    > :: Ord a => a -> a -> Bool
      ---> it is greater than operator and  returns bool value either true or false
      ---> type info:
                :> :t 4 > 5
                4 > 5 :: Bool

          Example:
          :> 4 >5
          False
          :> 4 > (-1)
          True
          :>
          :> 0 > (0)
          False
          :> 0 > (10)
          False
          :> 0 > (-10)
          True

          :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
          :> Orange > Red
          True
          :>
          :> Red>Violet
          False
-}

--compare------------------------------------------------------------------------
{-
    compare :: Ord a => a -> a -> Ordering
            ---> The function returns "less than" if the first argument is less than the second one,
                  "equal" if the arguments are equal, and
                  "greater than" if the first argument is grater than the second one.
            ---> type info:
                      :> :t compare 2 4
                      compare 2 4 :: Ordering

            Examples:

            :> compare 2 4
            LT
            :> compare 2 (-4)
            GT
            :> compare (0) (0)
            EQ
            :> compare ("Abc") ("abc")
            LT
            :> compare ("abc") ("abc")
            EQ
            :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
            :> compare (Red)(Orange)





-- ++ ---------------------------------------------------------------------------
{-
    ++ ::  type info:
                (++) :: [a] -> [a] -> [a]

        ----> this operator helps in concatinating list or Strings
            Examples:
            :> "abc" ++ "cde"
            "abccde"
            :>
            :> "abc" ++ ""
            "abc"
            :> "" ++ ""
            ""
            :> [1,2]  ++ [3,4]
            [1,2,3,4]
            :> [1,2]  ++ [3,-4]
            [1,2,3,-4]

-}

-- &&, ||------------------------------------------------------------------------
{-
  && :: :> :info &&
            (&&) :: Bool -> Bool -> Bool

      ---> this operator takes boolean values as input and gives bool value as output

      Examples:
        :> True && False
        False
        :> True && True
        True
        :> False && False
        False
        :> False && True
        False

  || :: :> :info ||
        (||) :: Bool -> Bool -> Bool

        ---> this operator takes boolean values as input and gives bool value as output

      Examples:
        :> True || True
        True
        :> True || False
        True
        :> False || False
        False
        :> False || True
        True
-}

--toEnum-------------------------------------------------------------------------
{-
  toEnum :: it returns the item at argument position from an enumration
        ---> type info:
                   toEnum :: Enum a => Int -> a
      Example:

      data XXX = AA|BB|CC|DD deriving (Enum, Show)
      :> toEnum 0::XXX
      AA

      :> toEnum 3::XXX
      DD

      :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
      :> toEnum 1 :: Color
      Orange

      Error case:
      :> toEnum 7 :: Color
      *** Exception: toEnum{Color}: tag (7) is outside of enumeration's range (0,5)
      CallStack (from HasCallStack):
        error, called at <interactive>:256:85 in interactive:Ghci70

-}

--fromEnum-----------------------------------------------------------------------
{-
  fromEnum :: it returns the argument position from an enumeration
           ---> type info:
                    Enum a => a -> Int

        Examples:
        :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
        :> toEnum 1 :: Color
        :> fromEnum Red
        0
        :> fromEnum Orange
        1
        :> fromEnum Yellow
        2
        :> fromEnum Peach
        <interactive>:271:10: error: Data constructor not in scope: Peach
-}

--enumFrom-----------------------------------------------------------------------
{-
  enumFrom :: it returns an array of members of an enumeration starting with the argument, it is equivalent to syntax
           ---> type info:
                    Enum a => a -> [a]e

      Examples:
        :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
        :> enumFrom Red
        [Red,Orange,Yellow,Green,Blue,Violet]
        :>
        :> enumFrom Violet
        [Violet]
        :>
        :> enumFrom Red
        [Red,Orange,Yellow,Green,Blue,Violet]
        :>
        :> enumFrom Yellow
        [Yellow,Green,Blue,Violet]

-}

--enumFromThen-------------------------------------------------------------------
{-
   enumFromThen :: This operator returns an array of arguments of an enumeration starting with the first argument and with
                   the distances 0,1,2,3,4,5,6,7.. *.
              ---> type info:
                       Enum a => a -> a -> [a]
         Examples:
          :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)

          --distance is 1 between elements
          :> enumFromThen Red Orange
          [Red,Orange,Yellow,Green,Blue,Violet]

          --distance is 2 between elements
          :> enumFromThen Red Yellow
          [Red,Yellow,Blue]

          --distance is three between elements
          :> enumFromThen Red Violet
          [Red,Violet]

          -- distance is three but in reverse order from back to front
          :> enumFromThen Violet Red
          [Violet,Red]

          --distance is 2 from end to front
          :> enumFromThen Violet Green
          [Violet,Green,Orange]
-}

--enumFromTo---------------------------------------------------------------------
{-
    enumFromTo :: It returns an array of members from an enum starting with the first argument and
                  finishing with the second one.
               ---> type info ::
                        Enum a => a -> a -> [a]
        Examples:

        :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
        :> enumFromTo Red Orange
        [Red,Orange]
        :> enumFromTo Red Violet
        [Red,Orange,Yellow,Green,Blue,Violet]
        :> enumFromTo Red Green
        [Red,Orange,Yellow,Green]

        -- no color from Blue to Green
        :> enumFromTo Blue Green
        []
-}

--enumFromThenTo-----------------------------------------------------------------
{-
    enumFromThenTo ::
                  ---> type info :
                          Enum a => a -> a -> a -> [a]

          Examples:
          :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
          :> enumFromThenTo Red Yellow Violet
          [Red,Yellow,Blue]
          :> enumFromThenTo Red Green Violet
          [Red,Green]
          :> enumFromThenTo Red Green Violet
          [Red,Green]
          :> enumFromThenTo Red Green Red
          [Red]
-}


--all----------------------------------------------------------------------------
{-
    all :: it will return true if all arguments satisfy the conditions otherwise false will be return
         type info : (a -> Bool) -> [a] -> Bool
      Examples:
      :> :{
      Prelude| function n = all (<10) n
      Prelude| :}
      :> function [1,2,3,4]
      True


      :> :{
      Prelude| function n = all (<5) n
      Prelude| :}
      :> function [6,7,7,46]
      False

      :> :{
      Prelude| function n = all (==1) n
      Prelude| :}
      :> function [1,1,1]
      True

      :> :{
      Prelude| function n = all (==1) n
      Prelude| :}
      :> function [1,1,1,0]
      False


      :> :{
      Prelude| function n = all (even) n
      Prelude| :}
      :> function [2,3]
      False
      :> function [2,4]
      True
-}


--any----------------------------------------------------------------------------
{-
    any :: it will returns True if at least one item in the list fullfills the condition
        type info: (a -> Bool) -> [a] -> Bool

    Examples:
    :> :{
    Prelude| function n = any (even) n
    Prelude| :}

    :> function [2,4,3]
    True

    :> function [1,1,3]
    False

    :> :{
    Prelude| function n = any (==1) n
    Prelude| :}
    :> function [1,1,3]
    True
-}

--break--------------------------------------------------------------------------
{-
    break:: it will creates a tuple of two lists from the original one separated at condition boundary
          type info: 	(a -> Bool) -> [a] -> ([a],[a])

    Examples:
    :> :{
    Prelude| function n = break (==1) n
    Prelude| :}
    :> function [0,1,1,3]
    ([0],[1,1,3])

    :> :{
    Prelude| function n = break (==4) n
    Prelude| :}

    :> function [0,1,1,3]
    ([0,1,1,3],[])

    :> function [0,1,1,3,4]
    ([0,1,1,3],[4])

    :> function [0,1,1,3,4,5]
    ([0,1,1,3],[4,5])

    :> function [0,1,1,3,4,5,9]
    ([0,1,1,3],[4,5,9])
-}

--dropWhile----------------------------------------------------------------------
{-
    dropWhile :: (a -> Bool) -> [a] -> [a]
            ---> 	When condition fails for the first time, a new list will be created from the original
            one till the end of list

     Examples:
      :> :{
      Prelude| function n = dropWhile (<4) n
      Prelude| :}
      :> function [0,1,1,3,4,5,9]
      [4,5,9]
      :>

      :> dropWhile ('w'>) "hello, world"
      "world"

      :> dropWhile even [2,4,3,6,8,10]
      [3,6,8,10]


-}

--takeWhile----------------------------------------------------------------------
{-
  takeWhile :: a -> Bool) -> [a] -> [a]
            It will creates a list from another one, first it iterate the original list and takes elements from it till
             the moment when the condition fails, then it stops processing
    Examples:


    :> :{
    Prelude| function n =  takeWhile(>4) n
    Prelude| :}
    :> function [0,1,1,3,4,5,9]
    []

    :> :{
    Prelude| function n =  takeWhile(<4) n
    Prelude| :}
    :> function [0,1,1,3,4,5,9]
    [0,1,1,3]

    :> takeWhile ('w'>) "hello world"
    "hello "
-}

--filter-------------------------------------------------------------------------
{-
    filter :: (a -> Bool) -> [a] -> [a]
          ---> It will return a list constructed from members of a list fulfilling a condition given by the first argument

    Examples:
    :> filter (>5) [1,2,3,4,5,6,7,8]
    [6,7,8]
    :> filter (>10) [1,2,3,4,5,6,7,8]
    []
    :> filter (>5) [1,2,3,4,5,6,7,8]
    [6,7,8]
    :> filter (>"abc") ["abc","cde","edg"]
    ["cde","edg"]
    :> filter (>(-2)) [-1,-2,-3,-4,-15]
    [-1]
-}


--iterate -----------------------------------------------------------------------
{-
  iterate :: This function takes a function and starting value and applies function to starting value,
             this cycle repeats and furthermore function is applied to last result and this cycle continues for infinite time.
          --->	(a -> a) -> a -> [a]

    Examples:

    :> take 10 (iterate (2*)1)
    [1,2,4,8,16,32,64,128,256,512]

    :> take 10 (iterate (2*)(-1))
    [-1,-2,-4,-8,-16,-32,-64,-128,-256,-512]

    :> take 50 (iterate (2*)(-1))
    [-1,-2,-4,-8,-16,-32,-64,-128,-256,-512,-1024,-2048,-4096,-8192,-16384,-32768,-65536,-131072,-262144,-524288,-1048576,-2097152,-4194304,-8388608,-16777216,-33554432,-67108864,-134217728,-268435456,-536870912,-1073741824,-2147483648,-4294967296,-8589934592,-17179869184,-34359738368,-68719476736,-137438953472,-274877906944,-549755813888,-1099511627776,-2199023255552,-4398046511104,-8796093022208,-17592186044416,-35184372088832,-70368744177664,-140737488355328,-281474976710656,-562949953421312]


-}


--map----------------------------------------------------------------------------
{-
  map :: (a -> b) -> [a] -> [b]
      ---> It will return the list by applying sub function to the list and return the resulted lists

    Examples:

    :> map abs [-1,-3,4,-12]
[1,3,4,12]
:> map (3*)[33,44,55,66]
[99,132,165,198]
:> map ((-10)*)[33,44,55,66]
[-330,-440,-550,-660]
:> map (print) [1,-3,5,-6,70]

<interactive>:516:1: error:
    • No instance for (Show (IO ())) arising from a use of ‘print’
    • In a stmt of an interactive GHCi command: print it
-}



--span---------------------------------------------------------------------------
{-
  span :: span :: (a -> Bool) -> [a] -> ([a], [a])
      ---> span function is Haskell is to apply a predicate to a list,
      and return a tuple where the first element is elements in the list that satisfy that predicate
      and the second element is the reminder of the list.

    Examples:
    :> span (<3) [1,2,4,5,6]
    ([1,2],[4,5,6])

    :> span(==4)[-1,2,-4,4,0,6]
    ([],[-1,2,-4,4,0,6])
    :> span(<4)[-1,2,-4,4,0,6]
    ([-1,2,-4],[4,0,6])
    :> span(>4)[-1,2,-4,4,0,6]
    ([],[-1,2,-4,4,0,6])
-}

-- == && /=----------------------------------------------------------------------
{-
    == :: (==) :: a -> a -> Bool
      ---> this operator is used to check euqality between two arguments and return a boolean values
      :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
      :> 5==0
      False
      :> 5==5
      True
      :> 5 /=0
      True
      :>
      :>
      :> 5==(-1)
      False
      :> Red == Orange
      False
      :>
      :> Red == Red
      True


      /= ::(/=) :: a -> a -> Bool
        ---> this operator is used to check equality between two arguments and return true is arguments are unequal otherwise it will return false
        :> data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Show, Eq, Ord, Enum)
        :> Red /= Orange
        True
        :> Red /= Red
        False
        :> 5 /=(-1)
        True
        :>
        :>
        :> 40/=40
        False

-}
