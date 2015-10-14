let contents = "let duplicate5 = failwith \"To do: Implement duplicate5\";;
"

let () =
    let file = open_out "wk3ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;