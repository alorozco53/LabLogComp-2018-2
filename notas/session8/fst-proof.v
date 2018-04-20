(* Ejemplos de tácticas de pruebas en Coq. *)
(* Author: AlOrozco53 *)

(* Ejemplos simples *)
Theorem my_first_proof__again : (forall A : Prop, A -> A).
Proof.
  intros A.
  intros proof_of_A.
  exact proof_of_A.
Qed.

(* Ejemplo que usa el comando pose *)
Theorem forward_small : (forall A B : Prop, A -> (A->B) -> B).
Proof.
 intros A.
 intros B.
 intros proof_of_A.
 intros A_implies_B.
 pose (proof_of_B := A_implies_B proof_of_A).
 exact proof_of_B.
Qed.

(* Ejemplo que refina una implicación, requiriendo probar la premisa *)
Theorem backward_small : (forall A B : Prop, A -> (A->B)->B).
Proof.
 intros A B.
 intros proof_of_A A_implies_B.
 refine (A_implies_B _).
   exact proof_of_A.
Qed.

(* Mismo ejemplo de arriba pero con tácticas más simples *)
Theorem simple_implication : (forall A B : Prop, A -> (A->B)->B).
Proof.
  intros.
  apply H0 in H.
  exact H.
Qed.

Theorem proof3 : (forall A B: Prop, (A -> B -> (A /\ B))).
Proof.
 intros.
 split.
 exact H.
 exact H0.
Qed.

Theorem or_commutative : (forall A B: Prop, A \/ B -> B \/ A).
Proof.
 intros.
 elim H.
 intros.
 right.
 exact H0.
 intros.
 left.
 exact H0.
Qed.

Theorem thm_true_imp_false : ~(True -> False).
Proof.
  intros T_implies_F.
  refine (T_implies_F _).
    exact I.
Qed.

Theorem absurd2 : forall A C : Prop, A -> ~ A -> C.
Proof.
  intros A C.
  intros proof_of_A proof_that_A_cannot_be_proven.
  unfold not in proof_that_A_cannot_be_proven.
  pose (proof_of_False := proof_that_A_cannot_be_proven proof_of_A).
  case proof_of_False.
Qed.

Theorem demorgan0 : (forall A B : Prop, ~(A \/ B) <-> ((~A) /\ (~B))).
Proof.
 intros.
 split.
 intros.
 unfold not in H.
 split.
 unfold not.
 intros.
 refine (H _).
 left.
 exact H0.
 unfold not.
 intros.
 refine (H _).
 right.
 exact H0.
 intros.
 destruct H.
 unfold not in H.
 unfold not in H0.
 unfold not.
 intros.
 case H1.
 intros.
 apply H in H2.
 exact H2.
 intros.
 apply H0 in H2.
 exact H2.
Qed.

Variable D : Set.

Variable P : D -> Prop.

Variable Q : D -> Prop.

Lemma lemdisj :
(forall x : D, ((P x \/ Q x) /\ (~P x)) -> Q x).
Proof.
 intros.
 destruct H.
 unfold not in H0.
 case H.
 unfold not in H0.
 intros.
 apply H0 in H1.
 case H1.
 intros.
 exact H1.
Qed.

Theorem ex0 :
  (exists x : D , (~P x \/ Q x)) -> (exists x : D, ~(P x /\ ~Q x)).
Proof.
  intros.
  destruct H.
  exists x.
  unfold not.
  intros.
  destruct H0.
  case H.
  intros.
  unfold not in H2.
  apply H2 in H0.
  exact H0.
  intros.
  apply H1 in H2.
  exact H2.
Qed.

Lemma ex1 :
  (forall P Q R S : Prop, ((~P \/ Q -> R) /\ ~S /\ (~S -> Q /\ P)) -> R).
Proof.
  intros.
  destruct H.
  destruct H0.
  apply H1 in H0.
  destruct H0.
  refine (H _).
  right.
  exact H0.
Qed.

Lemma int_or_ex :
  (forall Q R : Prop, (Q -> R) /\ (R -> Q) -> (Q <-> R)).
Proof.
  intros.
  destruct H.
  split.
  exact H.
  exact H0.
Qed.

Lemma simple_fol :
  ((forall x : D, P x) /\ (forall x : D, Q x) -> (forall x : D, P x /\ Q x)).
Proof.
  intros.
  destruct H.
  specialize (H x).
  specialize (H0 x).
  split.
  exact H.
  exact H0.
Qed.


Theorem false_cannot_be_proven :
  (~False).
Proof.
  unfold not.
  intros.
  trivial.
Qed.

Lemma l2 :
  (forall A B : Prop, (A /\ B) -> A \/ B).
Proof.
  intros.
  right.
  destruct H.
  exact H0.
Qed.