let contents = "let loop = failwith \"To do: Implement loop\";;
"

let () =
    let file = open_out "wk6ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;