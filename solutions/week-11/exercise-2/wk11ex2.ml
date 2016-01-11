open Common;;

let pad p = [O; O] @ p @ [O; O]

let rec normalise' = function
  | O :: ls -> normalise' ls
  | ls      -> ls

let normalise ls =
  let ls = normalise' ls in
  let ls = ls |> List.rev |> normalise' |> List.rev in
  ls

let rec take n xs =
  if n = 0 then [] else (List.hd xs) :: (take (n - 1) (List.tl xs))

let rec drop n xs =
  if n = 0 then xs else drop (n - 1) (List.tl xs)

let move ls (i, m) =
  if i < 0 || i >= List.length ls then None
  else
  (* shift because added new elements *)
  let i = i + 2 in
  let ls = pad ls in
  (* ls' l0 l1 l2 l3 l4 ls'' *)
  let ls' = take (i-2) ls    in
  let l0 = List.nth ls (i-2) in
  let l1 = List.nth ls (i-1) in
  let l2 = List.nth ls i     in
  let l3 = List.nth ls (i+1) in
  let l4 = List.nth ls (i+2) in
  let ls'' = drop (i+3) ls   in
  match m, l0, l1, l2, l3, l4 with
  | ML, l0,  O,  L, l3, l4 -> Some (ls' @ [l0;  L;  O; l3; l4] @ ls'' |> normalise)
  | JL,  O,  R,  L, l3, l4 -> Some (ls' @ [ L;  R;  O; l3; l4] @ ls'' |> normalise)
  | MR, l0, l1,  R,  O, l4 -> Some (ls' @ [l0; l1;  O;  R; l4] @ ls'' |> normalise)
  | JR, l0, l1,  R,  L,  O -> Some (ls' @ [l0; l1;  O;  L;  R] @ ls'' |> normalise)
  | _ -> None

let rec play ls moves = 
  if ls = [] then Some []
  else match moves with
  | m :: ms ->
    (match move ls m with
     | Some ls' -> play ls' ms
     | None -> None)
  | [] -> Some ls
