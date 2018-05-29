(* Dos ejercicios de traducción del lenguaje natural a lógica *)
(* Author: AlOrozco53 *)
(* Version: 0.1 *)

(* "A" es un mundo de vampiros, brujas y sepultureros *)
Variable A : Set.

(* ser feliz *)
Variable F : A -> Prop.

(* ser vampiro *)
Variable V : A -> Prop.

(* ser bruja *)
Variable B : A -> Prop.

(* emborracharse *)
Variable E : A -> Prop.

(* pernoctar en un cementerio *)
Variable P : A -> Prop.

(* violar la ley *)
Variable L : A -> Prop.

(* ser sepulturero *)
Variable S : A -> Prop.

(* convivir *)
Variable C : A -> A -> Prop.

Theorem ej6 :
  (((forall x : A, F x -> (V x /\ (E x \/ P x)))
    /\
    (forall x : A, P x -> (L x \/ S x))
    /\
    (forall x : A, F x -> (B x /\ (exists y : A, V y /\ F y
                                                 /\ ~E y /\ ~L y)))
    /\
    (exists x : A, B x /\ F x))
   ->
   (exists x : A, V x /\ S x)).
Proof.
  intros.
  destruct H.
  destruct H0.
  destruct H1.
  destruct H2.
  destruct H2.
  specialize (H1 x).
  apply H1 in H3 as H4.
  destruct H4.
  destruct H5.
  exists x0.
  destruct H5.
  destruct H6.
  destruct H7.
  split.
  assumption.
  specialize (H x0).
  apply H in H6 as H9.
  destruct H9.
  case H10.
  intros.
  contradiction.
  intros.
  specialize (H0 x0).
  apply H0 in H11 as H12.
  case H12.
  intros.
  contradiction.
  intros.
  assumption.
Qed.

(* el patrónum lo hizo snape *)
Variable ps : Prop.

(* hay que jugar quidditch *)
Variable jq : Prop.

(* molestar a Ron *)
Variable mr : Prop.

(* Slytherin es la mejor casa de Hogwarts *)
Variable sh : Prop.

Theorem ej7 :
  (ps \/ (jq /\ mr))
  /\
  (ps -> jq)
  /\
  (jq <-> sh)
  ->
  (jq /\ sh).
Proof.
  intros.
  destruct H.
  destruct H0.
  case H.
  intros.
  split.
  apply H0 in H2 as H3.
  assumption.
  destruct H1.
  apply H0 in H2 as H4.
  apply H1 in H4 as H5.
  trivial.
  intros.
  destruct H2.
  split.
  exact H2.
  destruct H1.
  apply H1 in H2 as H5.
  assumption.
Qed.
  
  
  