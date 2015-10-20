let sort2 (a, b) = if a < b 
                   then (a, b) 
                   else (b, a);;

let sort3 (a1, a2, a3) =
  let (a1, a2) = sort2 (a1, a2) in 
  let (a2, a3) = sort2 (a2, a3) in 
  let (a1, a2) = sort2 (a1, a2) in
  (a1, a2, a3);;

let sort4 (a1, a2, a3, a4) =
  let (a1, a2) = sort2 (a1, a2) in 
  let (a2, a3) = sort2 (a2, a3) in 
  let (a3, a4) = sort2 (a3, a4) in
  let (a1, a2, a3) = sort3 (a1, a2, a3) in
  (a1, a2, a3, a4);;

let perm4 a b = sort4 a = sort4 b;;
