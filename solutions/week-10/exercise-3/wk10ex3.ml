let enq a (xs, sx) = (a :: xs, sx)

let deq (xs, sx) = match sx with
  | x :: sx -> x, (xs, sx)
  | [] -> if xs = []
    then failwith "deq"
    else let sx = List.rev xs in
      (List.hd sx, ([], List.tl sx))

let rec findseg n queue sum xs =
  (sum = n) ||
  (sum < n) && (xs <> []) && (
    let x = List.hd xs in
    let xs = List.tl xs in
    let sum = sum + x in
    let queue = enq x queue in
    findseg n queue sum xs) ||
  (sum > n) && (
    let x, queue = deq queue in
    let sum = sum - x in
    findseg n queue sum xs);;

let has_seg xs n = findseg n ([], []) 0 xs;;
