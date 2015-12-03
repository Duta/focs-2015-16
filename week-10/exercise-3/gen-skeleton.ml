let contents = "let has_seg = failwith \"To do: Implement has_seg\";;
"

let () =
    let file = open_out "wk10ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;