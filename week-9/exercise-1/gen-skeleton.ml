let contents = "(* Do not delete this line. This includes the nat type from common.ml
   Do not redefine the nat type. *)
open Common;;

let sub = failwith \"To do: Implement sub\";;
"

let () =
    let file = open_out "wk9ex1.ml" in
    Printf.fprintf file "%s" contents;
    close_out file;;