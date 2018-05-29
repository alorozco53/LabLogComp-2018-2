(* Práctica 3 *)
(* Author: AlOrozco53 *)
(* Version: 0.1 *)

Theorem ej1 :
  (forall p q r s : Prop,
      (p -> q)
      /\
      (q -> r \/ s)
      /\
      ~s
      /\
      p
      -> r).
Proof.
  intros.
  destruct H.
  destruct H0.
  destruct H1.
  apply H in H2 as H3.
  apply H0 in H3 as H4.
  case H4.
  intros.
  exact H5.
  intros.
  contradiction.
Qed.

Theorem ej2 :
  (forall p q r : Prop,
      ((p -> q)
        ->
        ((p \/ r)
         ->
         ~~(q \/ r)))).
Proof.
  intros.
  unfold not.
  intros.
  case H0.
  intros.
  refine (H1 _).
  left.
  apply H in H2.
  assumption.
  intros.
  refine (H1 _).
  right.
  assumption.
Qed.

Variable D : Set.
Variable Q : D -> Prop.
Variable P : D -> Prop.
Variable R : D -> Prop.
Variable S : D -> Prop.
Variable f : D -> D.
Variable g : D -> D.
Variable b : D.
Variable a : D.

Theorem ej3 :
  (((exists x : D, Q x)
    /\
    (forall x : D, (Q x /\ exists y : D, P y)
                   -> Q (f x))
    /\
    (forall z : D, (Q z -> Q (g z))))
   ->
   (P b -> exists w : D, Q (f (g w)))).
Proof.
  intros.
  destruct H.
  destruct H1.
  destruct H.
  specialize (H2 x).
  apply H2 in H.
  specialize (H1 (g x)).
  exists x.
  refine (H1 _).
  split.
  exact H.
  exists b.
  exact H0.
Qed.

Theorem ej4 :
  ((exists x : D, ~P x \/ Q x)
  ->
  (exists x : D, (~(P x /\ ~Q x)))).
Proof.
  intros.
  destruct H.
  exists x.
  unfold not.
  intros.
  unfold not in H.
  destruct H0.
  case H.
  intros.
  apply H2 in H0.
  assumption.
  intros.
  apply H1 in H2.
  assumption.
Qed.

Theorem ej5 :
  ((forall x : D, P x -> Q x)
    /\
    (forall y : D, (R b \/ Q y) -> S a))
   ->
   (forall z : D, P z -> (exists y : D, S y)).
Proof.
  intros.
  destruct H.
  exists a.
  specialize (H z).
  apply H in H0.
  specialize (H1 z).
  refine (H1 _).
  right.
  exact H0.
Qed.