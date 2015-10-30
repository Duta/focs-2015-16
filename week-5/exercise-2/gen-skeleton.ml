let contents = "let shiftrotate = failwith \"To do: Implement shiftrotate\";;
"

let () =
    let file = open_out "wk5ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;