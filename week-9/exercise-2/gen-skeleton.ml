let contents = "open Num;;

let root = failwith \"To do: Implement root\";;
"

let () =
    let file = open_out "wk9ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;