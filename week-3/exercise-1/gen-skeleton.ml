let contents = "let sort5 = failwith \"To do: Implement sort5\";;
"

let () =
    let file = open_out "wk3ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;