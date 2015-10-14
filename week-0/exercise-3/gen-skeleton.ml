let contents = "let zero = failwith \"To do: Implement zero\";;
"

let () =
    let file = open_out "wk0ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;