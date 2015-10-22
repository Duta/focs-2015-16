let contents = "let dec = failwith \"To do: Implement dec\";;
"

let () =
    let file = open_out "wk4ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;