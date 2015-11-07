let rec dif xs ys = match xs with
| []                         -> []
| x :: xs when List.mem x ys -> dif xs ys
| x :: xs                    -> x :: (dif xs ys)

let dif xs ys = (dif xs ys) @ (dif ys xs)
