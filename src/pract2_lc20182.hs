{- |
Module      :  Práctica 2
Maintainer  :  alorozco.patriot53@gmail.com
Stability   :  experimental
Portability :  portable
Version     :  0.1
-}

module Practica2 where


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

type Sub = (String, Term)

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

type Universe a = [a]

type Ambient a = String -> a

type FunctCtx a = String -> [a] -> a

type PredCtx a = String -> [a] -> Bool

type Model a = (Universe a, Ambient a, FunctCtx a, PredCtx a)

-- Interpretación de términos
interpTerm :: Term -> Model a -> a
interpTerm = error "TBD"

-- Interpretación de predicados
interpPred :: Predicate -> Model a -> Bool
interpPred = error "TBD"
