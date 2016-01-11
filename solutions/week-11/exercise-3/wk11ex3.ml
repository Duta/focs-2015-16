open Common;;

let rec normalise' = function
  | O :: ls -> normalise' ls
  | ls      -> ls

let normalise ls =
  let ls = normalise' ls in
  let ls = ls |> List.rev |> normalise' |> List.rev in
  ls

let pad p = [O; O] @ p @ [O; O]

(* --------- From 11.1 --------- *)

let rec winning b = function
  | [] -> true
  | L :: ls when b -> winning true  ls
  | O :: ls when b -> winning true  ls
  | R :: ls when b -> winning false ls
  | L :: ls        -> false
  | O :: ls        -> winning false ls
  | R :: ls        -> winning false ls

let solved ls = winning true ls

(* --------- End of 11.1 --------- *)

(* --------- From 11.2 --------- *)

let rec take n xs =
  if n = 0 then [] else (List.hd xs) :: (take (n - 1) (List.tl xs))

let rec drop n xs =
  if n = 0 then xs else drop (n - 1) (List.tl xs)

let move ls (i, m) =
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

let rec play ls = function
  | m :: ms ->
    (match move ls m with
     | Some ls' -> play ls' ms
     | None -> None)
  | [] -> Some ls

(* --------- End of 11.2 --------- *)

(* --------- 11.3 --------- *)

(* Printing helpers *)
let rec print_path = function
  | (i, MR) :: ms ->
    print_char '(';
    print_int i;
    print_char ',';
    print_string "move right);";
    print_path ms
  | (i, JR) :: ms  ->
    print_char '(';
    print_int i;
    print_char ',';
    print_string "jump right);";
    print_path ms
  | (i, ML) :: ms  ->
    print_char '(';
    print_int i;
    print_char ',';
    print_string "move left);";
    print_path ms
  | (i, JL) :: ms  ->
    print_char '(';
    print_int i;
    print_char ',';
    print_string "jump left);";
    print_path ms
  | [] -> print_newline ()

let rec print_fringe = function
  | [] -> print_endline "--"
  | p :: ps -> print_path p; print_fringe ps

let rec print_position = function
  | L :: ls -> print_string "L"; print_position ls
  | O :: ls -> print_string " "; print_position ls
  | R :: ls -> print_string "R"; print_position ls
  | [] -> ()

(* End of printing helpers *)

let rec search
    (expand : 'a list -> 'a list list)
    (fringe : 'a list list)
    (goal : 'a list -> bool)
    (strategy : 'a list list -> 'a list list -> 'a list list)
  =
  (*print_string "Searching in\n";
  print_fringe fringe;*)
  match fringe with
  | []                           -> None
  | path :: paths when goal path -> Some path
  | path :: paths                ->
    let newpaths = expand path in
    let fringe = strategy newpaths paths in
    search expand fringe goal strategy

let rec count_distance d l = function
  | [] -> 0
  | R :: ls when l = R -> d + count_distance (d+1) l ls
  | L :: ls when l = L -> d + count_distance (d+1) l ls
  | _ :: ls            ->     count_distance (d+1) l ls

let how_bad position = count_distance 0 L position + count_distance 0 R (List.rev position)

let goal initial p =
  match play initial p with
  | None -> false
  | Some position ->
    (*print_string "Considering: ";
    print_position position;
    print_string " (bad = ";
    print_int (how_bad position);
    print_string ")\n";*)
    winning true position

let rec next_moves i = function
  | l0 ::  O ::  L :: l3 :: l4 :: ls' as ls -> (i, ML) :: (next_moves (i+1) (List.tl ls))
  | O  ::  R ::  L :: l3 :: l4 :: ls' as ls -> (i, JL) :: (next_moves (i+1) (List.tl ls))
  | l0 :: l1 ::  R ::  O :: l4 :: ls' as ls -> (i, MR) :: (next_moves (i+1) (List.tl ls))
  | l0 :: l1 ::  R ::  L ::  O :: ls' as ls -> (i, JR) :: (next_moves (i+1) (List.tl ls))
  | l0 :: l1 :: l2 :: l3 :: l4 :: ls' as ls -> (next_moves (i+1) (List.tl ls))
  | _ -> []

let rec expand initial path =
  match play initial path with
  | None -> []
  | Some position ->
    List.map
      (fun move -> path @ [move])
      (next_moves 0 (pad position))

(* many paths reach the same position, we don't need to keep track of all of them *)
let rec stuck = function
  | R :: R :: L :: L :: _ -> true
  | x :: xs -> stuck xs
  | [] -> false

let rec filter init positions = function
  | [] -> []
  | path :: paths ->
    (match play init path with
     | None -> filter init positions paths
     | Some position when stuck position              -> filter init positions paths
     | Some position when List.mem position positions -> filter init positions paths
     | Some position                                  -> path :: (filter init (position :: positions) paths))


let how_bad' init path =
  match play init path with
  | None -> max_int
  | Some position -> how_bad position

let rec strategy init paths paths' =
  paths @ paths'
  |> filter init []
  |> List.sort (fun p p' -> how_bad' init p - how_bad' init p')

let solve init = search
          (expand init)
          (List.map (fun x -> [x]) (next_moves 0 (pad init)))
          (goal init)
          (strategy init)
