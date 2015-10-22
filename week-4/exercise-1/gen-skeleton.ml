let contents = "let enc = failwith \"To do: Implement enc\";;
"

let () =
    let file = open_out "wk4ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;