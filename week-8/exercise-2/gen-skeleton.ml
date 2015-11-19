let contents = "let split = failwith \"To do: Implement split\";;
"

let () =
    let file = open_out "wk8ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;