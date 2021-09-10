deal xs =
     let (a,b) = partition (odd . snd) (zip xs [1..])
     in ( (map fst a), (map fst b))



     deal :: [a] -> ([a],[a])
     deal [] = ([],[])
     deal (x:xs) = let (ys,zs) = deal xs
                   in
