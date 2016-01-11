open Common;;

(* b : are we still scanning Ls? *)
let rec winning b = function
  | [] -> true
  | L :: ls when b -> winning true  ls
  | O :: ls when b -> winning true  ls
  | R :: ls when b -> winning false ls
  | L :: ls        -> false
  | O :: ls        -> winning false ls
  | R :: ls        -> winning false ls;;

let solved ls = winning true ls;;
