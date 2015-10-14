let contents = "let mid5 = failwith \"To do: Implement mid5\";;
"

let () =
    let file = open_out "wk3ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;