(* Helper function to remove all leading occurrences of x in a list *)
let rec rmhead x = function
  | [] -> []
  | y :: ys when x = y -> rmhead x ys
  | ys -> ys
  
(* Note: This works on sorted functions only! 
   We go through both arguments at the same time.
   The argument zs is an accumulator for a tail-recursive implementation. *)
let rec sim_dif' xs ys zs = match (xs, ys) with
  (* If one of the arguments is [] then we are done. *)
  | [], ys | ys, [] -> ys @ zs
  (* If the two arguments start with the same head 
     then we remove all the occurrences of it. *)
  | x :: xs , y :: ys when x = y ->
    let xs = rmhead x xs in
    let ys = rmhead y ys in 
    sim_dif' xs ys zs
  (* Otherwise we shift the smaller head onto the result and proceed. *)
  | x :: xs , y :: ys when x < y -> sim_dif' xs (y :: ys) (x :: zs)
  | x :: xs , y :: ys            -> sim_dif' (x :: xs) ys (y :: zs)

(* We first sort the two lists in ascending order. Note that this is not
   a very expensive operation but it makes the above possible and correct. *)
let sim_dif xs ys =
  let xs = List.sort compare xs in
  let ys = List.sort compare ys in
  sim_dif' xs ys []
