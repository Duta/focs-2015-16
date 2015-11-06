let contents = "let slump = failwith \"To do: Implement slump\";;
"

let () =
    let file = open_out "wk6ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;