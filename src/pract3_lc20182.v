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
Qed.

Theorem ej2 :
  (forall p q r : Prop,
      ((p -> q)
        ->
        ((p \/ r)
         ->
         ~~(q \/ r)))).
Proof.
Qed.

Variable D : Set.
Variable Q : D -> Prop.
Variable P : D -> Prop.
Variable f : D -> D.
Variable g : D -> D.
Variable b : D.

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
Qed.

Theorem ej4 :
  ((exists x : D, ~P x \/ Q x)
  ->
  (exists x : D, (~(P x /\ ~Q x)))).
Proof.
Qed.
