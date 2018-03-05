{- |
Module      :  Session3
Maintainer  :  alorozco.patriot53@gmail.com
Stability   :  experimental
Portability :  portable
Version     :  0.1
-}

module Session3 where


-- Cálculo de proposiciones
data Prop = VarP String            -- Variable proposicional
          | TTrue                  -- T
          | FFalse                 -- ⊥
          | Neg Prop               -- ¬ Φ
          | Conj Prop Prop         -- Φ ^ Ψ
          | Disj Prop Prop         -- Φ v Ψ
          | Imp Prop Prop          -- Φ -> Ψ
          | Equiv Prop Prop        -- Φ <-> Ψ


-- Imprime una fórmula utilizando operadores infijos
instance Show Prop where
  show (VarP s) = s
  show TTrue = "T"
  show FFalse = "F"
  show (Neg p) = "¬" ++ case p of
                          VarP s -> s
                          TTrue -> "T"
                          FFalse -> "F"
                          prop -> "(" ++ show prop ++ ")"
  show (Conj p q) = "(" ++ show p ++ ") ^ (" ++ show q ++ ")"
  show (Disj p q) = "(" ++ show p ++ ") v (" ++ show q ++ ")"
  show (Imp p q) = "(" ++ show p ++ ") -> (" ++ show q ++ ")"
  show (Equiv p q) = "(" ++ show p ++ ") <-> (" ++ show q ++ ")"









-- Forma normal negativa
nnf :: Prop -> Prop
nnf (VarP s) = VarP s
nnf TTrue = TTrue
nnf FFalse = FFalse
nnf (Neg p) = case p of
                VarP s -> Neg $ VarP s
                TTrue -> FFalse
                FFalse -> TTrue
                Neg q -> nnf q
                Conj q r -> Disj (nnf $ Neg q) (nnf $ Neg r)
                Disj q r -> Conj (nnf $ Neg q) (nnf $ Neg r)
                Imp q r -> Conj (nnf q) (nnf $ Neg r)
                Equiv q r -> nnf $ Neg $ Conj (Imp q r) (Imp r q)
nnf (Conj p q) = Conj (nnf p) (nnf q)
nnf (Disj p q) = Disj (nnf p) (nnf q)
nnf (Imp p q) = Disj (nnf $ Neg p) (nnf q)
nnf (Equiv p q) = nnf $ Conj (Imp p q) (Imp q p)

-- ¿Forma normal conjuntiva?
cnf :: Prop -> Prop
cnf = error "TBD"
