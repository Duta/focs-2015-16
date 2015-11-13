let contents = "let sim_dif = failwith \"To do: Implement sim_dif\";;
"

let () =
    let file = open_out "wk7ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;