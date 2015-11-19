let contents = "(* Do not remove this line. The puzzle constructor is defined in common.ml, so do not redefine it in your code. *)
open Common;;

let solvable = failwith \"To do: Implement solvable\";;
"

let () =
    let file = open_out "wk8ex3a.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;