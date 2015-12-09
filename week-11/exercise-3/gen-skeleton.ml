let contents = "(* Do not remove this line. The llama type is defined in common.ml, so please do not redefine it *)
open Common;;

let solve = failwith \"To do: Implement solve\";;
"

let () =
    let file = open_out "wk11ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;