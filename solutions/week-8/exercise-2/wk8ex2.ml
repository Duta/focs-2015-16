(* It is convenient to have an auxiliary function that keeps track of the current segment -- crt *)
let rec split' crt = function
  (* When we reach the end we return the current segement we were tracking *)
  | [] -> [crt]
  (* When the head is equal to the elements of the current segment we add x to the current segment. *)
  (* Note that since all the elements int crt are equal it is enough to compare with the head. *)
  | x :: xs when x = List.hd crt -> split' (x :: crt) xs
  (* If x is not equal to the elements of crt we have completed a segment. *)
  (* crt becomes part of the answer and the current segment is new, consisting of x only *)
  | x :: xs -> crt :: (split' [x] xs)

(* splitting the empty list is the empty list, otherwise we call split' where crt is just [x] *)
let split = function
  | [] -> []
  | x :: xs -> split' [x] xs
