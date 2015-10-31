let rec shiftrotate xs n = match n , xs with
| 0 , xs        -> xs
| n , []        -> []
| n , (x :: xs) -> shiftrotate (xs @ [x]) (n-1)
