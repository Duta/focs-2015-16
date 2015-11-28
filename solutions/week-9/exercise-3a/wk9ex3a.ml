let rec partition p ys zs = function
  | [] -> ys, zs
  | x :: xs when p x -> partition p (x :: ys) zs xs
  | x :: xs          -> partition p ys (x :: zs) xs

(* this assumes m and n have the same sign *)
let prot_sum m n = match m with
  | None   -> None
  | Some m ->
    if m = 0 then Some n
    else if (m > 0 && m + n > m) || (m < 0 && m + n < m) then Some (m + n)
    else None
                     
let rec add_no_of ps ns = match ps, ns with
  | [], xs | xs, [] -> List.fold_left prot_sum (Some 0) xs
  | p :: ps, n :: ns when p > -n -> add_no_of ((p+n) :: ps) ns
  | p :: ps, n :: ns when -n > p -> add_no_of ps ((p+n) :: ns)
  | p :: ps, n :: ns             -> add_no_of ps ns

let add xs =
  let ps, ns = partition ((<) 0) [] [] xs in
  let ps = List.sort compare ps in
  let ns = List.sort (fun x y -> 1 - compare x y) ns in
  add_no_of ps ns
