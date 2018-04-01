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

type Universe a = [a]

type Ambient a = String -> a

type FunctCtx a = String -> [a] -> a

type PredCtx a = String -> [a] -> Bool

type Model a = (Universe a, Ambient a, FunctCtx a, PredCtx a)

-- Interpretación de términos
interpTerm :: Term -> Model a -> a
interpTerm = error "TBD"


exfctx :: FunctCtx Int
exfctx "sum" args = case args of
                      [] -> error "function not a constant!"
                      xs -> foldl (+) 0 xs
exfctx "prod" args = case args of
                       [] -> error "function not a constant!"
                       xs -> foldl (*) 1 xs
exfctx const args = case args of
                      [] -> read const :: Int
                      _ -> error "constant must not have arguments"

expctx :: PredCtx Int
expctx "less" args = case args of
                       [] -> error "arity must be >= 1 !"
                       (x:xs) -> case xs of
                                   [] -> error "we need at least two arguments!"
                                   (y:_) -> x < y
expctx "equal" args = case args of
                        [] -> error "arity must be >= 1 !"
                        (x:xs) -> case xs of
                                    [] -> error "we need at least two arguments!"
                                    (y:_) -> x == y

examb :: Ambient Int
examb "x" = 1
examb "y" = 69
examb "z" = -4
examb "w" = 15
examb _ = error "not defined!"


-- Interpretación de predicados
interpPred :: Predicate -> Model a -> Bool
interpPred = error "TBD"
