(* Demostraciones en Wumpus World *)
(* Author: AlOrozco53 *)

Variable P : nat -> nat -> Prop.

Variable W : nat -> nat -> Prop.

Variable B : nat -> nat -> Prop.

Variable S : nat -> nat -> Prop.

Lemma l0 :
  ((P 1 1 -> W 4 6) /\ P 1 1) -> W 4 6.
Proof.
  intros.
  destruct H.
  apply H in H0.
  exact H0.
Qed.