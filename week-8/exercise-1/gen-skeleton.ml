let contents = "let replace = failwith \"To do: Implement replace\";;
"

let () =
    let file = open_out "wk8ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;