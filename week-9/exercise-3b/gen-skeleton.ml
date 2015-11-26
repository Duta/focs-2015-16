let contents = "(* author: Yu-Yang Lin *)
(* date: 23/11/2015 *)
(* This file contains a proof for associativity of add. *)

Signatures:
    add   : nat -> nat -> nat;

Definitions:
    [add 0] : forall n : nat . add zero n = n : nat;
    [add m] : forall m : nat . forall n : nat . add (suc m) n = suc(add m n) : nat;

Theorem [add assoc]:
    Statement: forall m : nat . forall n : nat . forall o : nat . add m (add n o) = add (add m n) o : nat
    Proof:
    TODO
    QED.
"

let () =
    let file = open_out "wk9ex3b.proof" in
    Printf.fprintf file "%s" contents;
    close_out file;;