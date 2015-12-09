let contents = "(* Do not remove this line. The llama and move types is defined in common.ml, so please do not redefine it *)
open Common;;

let play = failwith \"To do: Implement play\";;
"

let () =
    let file = open_out "wk11ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;