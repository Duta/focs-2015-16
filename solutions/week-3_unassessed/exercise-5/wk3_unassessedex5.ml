let next3 x a b c =
  if x = fst a then true, snd a, b, c
  else if x = fst b then true, snd b, a, c
  else if x = fst c then true, snd c, a, b
  else false, 0, (0, 0), (0, 0);;

let next2 x a b =
  if x = fst a then true, snd a, b
  else if x = fst b then true, snd b, a
  else false, 0, (0, 0);;

let next1 x a =
  if x = fst a then true, snd a else false, 0;;
		   
let loop a b c d =
  let x0 = fst a in 
  let x1 = snd a in
  let t1, x2, a, b = next3 x1 b c d in
  let t2, x3, a = next2 x2 a b in
  let t3, x4 = next1 x3 a in
  t1 && t2 && t3 && x0=x4
;;
