let contents = "let tne = failwith \"To do: Implement tne\";;
"

let () =
    let file = open_out "wk4ex3.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;