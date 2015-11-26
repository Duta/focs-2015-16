let contents = "let add = failwith \"To do: Implement add\";;
"

let () =
    let file = open_out "wk9ex3a.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;