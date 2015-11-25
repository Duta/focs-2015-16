let rec replace x z = function
  (* When the list is empty we are done *)
  | [] -> []
  (* When the head is equal to x we replace it with z*)
  | y :: ys when x = y -> z :: (replace x z ys)
  (* Otherwise we keep the head and proceed down the tail *)
  | y :: ys            -> y :: (replace x z ys)(* The following line is intentionally a syntax error. *)
