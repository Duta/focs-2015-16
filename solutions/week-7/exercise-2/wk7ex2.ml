let rec dif xs ys zs = match xs with 
  | [] -> zs
  | x :: xs when List.mem x ys -> dif xs ys zs
  | x :: xs -> dif xs ys (x :: zs)

(* When we call dif we need to provide the initial accumulator which is [] *)
let rec sim_dif xs ys = List.rev_append (dif xs ys []) (dif ys xs [])
