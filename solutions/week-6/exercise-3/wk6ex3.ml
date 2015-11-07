let rec slumplen x n = function
| []                 -> n
| y :: _ when y >= x -> n
| y :: ys            -> slumplen x (n+1) ys
 
(* max-length, max-index, crt-index *)
let rec slump' l k j = function
| []      -> (l, k)
| x :: xs -> let l' = slumplen x 0 xs in
             if l' > l then slump' l' j (j+1) xs
             else slump' l k (j+1) xs
 
let slump xs = slump' 0 0 0 xs;;
