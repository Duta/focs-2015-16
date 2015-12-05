let rec enq (x, (n:int)) = function
  | [] -> [(x, n)]
  | (x', n') :: xs when n' < n -> (x', n') :: (enq (x, n) xs)
  | (x', n') :: xs             -> (x, n) :: (x', n') :: xs;;

let rec deq xs =
  let rec deq' xs' = function
    | [] -> failwith "deq"
    | [x, (n:int)] -> (x, List.rev xs')
    | x :: xs -> deq' (x :: xs') xs in
  deq' [] xs;
