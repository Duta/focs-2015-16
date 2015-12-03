let contents = "let enq = failwith \"To do: Implement enq\";;
let deq = failwith \"To do: Implemenet deq\";;
"

let () =
    let file = open_out "wk10ex2.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;