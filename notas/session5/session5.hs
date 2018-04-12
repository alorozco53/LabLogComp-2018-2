{- |
Module      :  Session5
Maintainer  :  alorozco.patriot54@gmail.com
Stability   :  experimental
Portability :  portable
Version     :  0.1
-}

module Session5 where


-- Lógica de predicados
data Term = VarP String           -- Variable de predicado
          | Funct String [Term]   -- Función
          deriving Show


data Predicate = Pred String [Term]           -- P(t1, t2, ..., tn)
               | Neg Predicate                -- ¬ Φ
               | Conj Predicate Predicate     -- Φ ^ Ψ
               | Disj Predicate Predicate     -- Φ v Ψ
               | Imp Predicate Predicate      -- Φ -> Ψ
               | Equiv Predicate Predicate    -- Φ <-> Ψ
               | All String Predicate         -- ∀x Φ
               | Ex String Predicate          -- ∃x Φ
               deriving Show

-- | Sintaxis

-- Sustituciones

type Sub = String -> Term

sub1 :: Sub
sub1 "x" = Funct "f" [VarP "y"]
sub1 "y" = Funct "a" []
sub1 other = VarP other

-- Sustitución en términos
subTerm :: Term -> Sub -> Term
subTerm = error "TBD"

-- Sustitución en fórmulas de la lógica de predicados
subPred :: Predicate -> Sub -> Predicate
subPred = error "TBD"

-- Alfa-equivalencia
alphaEquiv :: Predicate -> Predicate -> Bool
alphaEquiv = error "TBD"


-- | Semántica

type FunctSymbols = [String]

type PredSymbols = [String]

type Universe a = [a]

type Model a = (Universe a, FunctSymbols, PredSymbols)

type Ambient a = String -> a

-- Interpretación de términos
interpTerm :: Term -> Model a -> Ambient a -> a
