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
    
let sort5 (a1, a2, a3, a4, a5) =
  let (a1, a2) = sort2 (a1, a2) in 
  let (a2, a3) = sort2 (a2, a3) in 
  let (a3, a4) = sort2 (a3, a4) in
  let (a4, a5) = sort2 (a4, a5) in
  let (a1, a2, a3, a4) = sort4 (a1, a2, a3, a4) in
  (a1, a2, a3, a4, a5);;

let mid5 (a, b, c, d, e) =
  let a, b, c, d, e = sort5 (a, b, c, d, e) in c;;
