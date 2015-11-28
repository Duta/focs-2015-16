open Num;;

let sgn x = 
  let z = num_of_int 0 in
	if x </ z then (-1)
	else if x >/ z then 1
	else 0;;

let rec root f a b err =
  let c = (a +/ b) // (num_of_int 2) in  
  if lt_num (b -/ a) (err) then c else
    let sgn_fa = (f a) |> sgn in
    let sgn_fc = (f c) |> sgn in
    if sgn_fc = 0 then c
    else if sgn_fa = sgn_fc then root f c b err 
    else root f a c err;;
