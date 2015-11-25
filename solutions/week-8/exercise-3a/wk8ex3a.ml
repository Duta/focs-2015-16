open Common;;

let rec replace x z = function
  (* When the list is empty we are done *)
  | [] -> []
  (* When the head is equal to x we replace it with z*)
  | y :: ys when x = y -> z :: (replace x z ys)
  (* Otherwise we keep the head and proceed down the tail *)
  | y :: ys            -> y :: (replace x z ys)

let rec solvable (xs : puzzle list) (ys : puzzle list) =
  match xs, ys with
  (* If we reach two empty lists we are done *)
  | [], [] -> true
  (* If the two heads are known and equal we proceed down the tails *)
  | K x :: xs, K y :: ys when x = y -> solvable xs ys
  (* If one head is known and one is unknown we replace the unknown with the known and proceed *)
  | (K x as x') :: xs, (U y as y') :: ys -> solvable (replace y' x' xs) (replace y' x' ys) 
  | (U x as x') :: xs, (K y as y') :: ys -> solvable (replace x' y' xs) (replace x' y' ys)
  (* If both heads are unknown we replace the second with the first and proceed *)
  | (U x as x'):: xs, (U y as y') :: ys -> solvable (replace x' y' xs) (replace x' y' ys)
  (* All other cases mean that we cannot solve the puzzle *)
  | _, _ -> false 
