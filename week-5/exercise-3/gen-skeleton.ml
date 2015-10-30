let contents = "let histo = failwith \"To do: Implement histo\";;
"

let () =
    let file = open_out "wk5ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;