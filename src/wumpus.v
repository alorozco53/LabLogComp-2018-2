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


Theorem secure_22 :
  ((~P 1 1 /\ ~W 1 1) /\
   (~P 1 1 <-> (~B 1 2 /\ ~B 2 1)) /\
   (~W 1 1 <-> (~S 1 2 /\ ~S 2 1)) /\
   (B 1 1 <-> (P 1 2 \/ P 2 1)) /\
   (S 1 1 <-> (W 1 2 \/ W 2 1)) /\
   (B 2 1 <-> (P 1 1 \/ P 2 2 \/ P 3 1)) /\
   (S 1 2 <-> (W 1 1 \/ W 2 2 \/ W 1 3)) /\
   (~B 1 1) /\
   (~S 1 1) /\
   (~B 1 2) /\
   (~S 2 1) /\
   (S 1 2) /\
   (B 2 1))
  -> (~P 2 2 /\ ~W 2 2).
Proof.
  intros.
  destruct H.
  destruct H0.
  destruct H1.
  destruct H2.
  destruct H3.
  destruct H4.
  destruct H5.
  destruct H6.
  destruct H7.
  destruct H8.
  destruct H9.
  destruct H10.
  destruct H.
  unfold not.
  split.
  intros.
  unfold not in H8.
  refine (H8 _).
  destruct H0.
  apply H0 in H.
  destruct H.
  contradiction.
  intros.
  unfold not in H9.
  refine (H9 _).
  destruct H1.
  apply H1 in H12.
  destruct H12.
  contradiction.
Qed.