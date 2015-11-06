let contents = "let dif = failwith \"To do: Implement dif\";;
"

let () =
    let file = open_out "wk6ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;