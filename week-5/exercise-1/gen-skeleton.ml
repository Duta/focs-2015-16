let contents = "let zip = failwith \"To do: Implement zip\";;
"

let () =
    let file = open_out "wk5ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;