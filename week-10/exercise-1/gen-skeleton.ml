let contents = "let enq = failwith \"To do: Implement enq\";;
let deq = failwith \"To do: Implement deq\";;
"

let () =
    let file = open_out "wk10ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;