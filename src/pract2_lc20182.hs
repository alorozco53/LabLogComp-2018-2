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

instance (Show Term) where
  show (VarP n) = n
  show (Funct n args) = case args of
                          [] -> n
                          xs -> n ++ "(" ++ showAux xs ++ ")"
    where
      showAux [] = ""
      showAux (y:ys) = show y ++ case ys of
                                   [] -> ""
                                   zs -> ", " ++ showAux zs

data Predicate = Pred String [Term]           -- P(t1, t2, ..., tn)
               | Neg Predicate                -- ¬ Φ
               | Conj Predicate Predicate     -- Φ ^ Ψ
               | Disj Predicate Predicate     -- Φ v Ψ
               | Imp Predicate Predicate      -- Φ -> Ψ
               | Equiv Predicate Predicate    -- Φ <-> Ψ
               | All String Predicate         -- ∀x Φ
               | Ex String Predicate          -- ∃x Φ


instance (Show Predicate) where
  show (Pred n args) = case args of
                         [] -> error "arity must be >= 1 !"
                         xs -> n ++ "(" ++ showAux xs ++ ")"
    where
      showAux [] = ""
      showAux (y:ys) = show y ++ case ys of
                                   [] -> ""
                                   zs -> ", " ++ showAux zs
  show (Neg p) = "¬(" ++ show p ++ ")"
  show (Conj p q) = "(" ++ show p ++ ") ^ (" ++ show q ++ ")"
  show (Disj p q) = "(" ++ show p ++ ") v (" ++ show q ++ ")"
  show (Imp p q) = "(" ++ show p ++ ") -> (" ++ show q ++ ")"
  show (Equiv p q) = "(" ++ show p ++ ") <-> (" ++ show q ++ ")"
  show (All x p) = "∀" ++ x ++ "(" ++ show p ++ ")"
  show (Ex x p) = "∃" ++ x ++ "(" ++ show p ++ ")"

-- | Sintaxis

-- Sustituciones

type Sub = (String, Term)

sub1 :: [Sub]
sub1 = [("x", Funct "f" [VarP "y"]),
        ("y", Funct "a" [])]

-- Obtiene una lista de todas las variables en un término
varsT :: Term -> [String]
varsT (VarP n) = [n]
varsT (Funct n args) = foldr (++) [] [varsT t | t <- args]

-- Obtiene una lista de todas las variables en una fórmula
varsP :: Predicate ->  [String]
varsP (Pred n args) = foldr (++) [] [varsT t | t <- args]
varsP (Neg phi) = varsP phi
varsP (Conj phi psi) = varsP phi ++ varsP psi
varsP (Disj phi psi) = varsP phi ++ varsP psi
varsP (Imp phi psi) = varsP phi ++ varsP psi
varsP (Equiv phi psi) = varsP phi ++ varsP psi
varsP (All x phi) = x : varsP phi
varsP (Ex x phi) = x : varsP phi

-- Sustitución en términos
subTerm :: Term -> Sub -> Term
subTerm (VarP n) s
  | n == fst s = snd s
  | otherwise = VarP n
subTerm (Funct n args) s = Funct n (map (\t -> subTerm t s) args)

-- Crea una nueva variable no presente en la fórmula dada
makeNewVar :: Predicate -> String
makeNewVar phi = let vars = varsP phi
                 in newvar vars 0
  where
    newvar variables acc
      | elem ("z" ++ show acc) variables = newvar variables (acc + 1)
      | otherwise = "z" ++ show acc

-- Sustitución en fórmulas de la lógica de predicados
subPred :: Predicate -> Sub -> Predicate
subPred (Pred n args) s = Pred n (map (\t -> subTerm t s) args)
subPred (Neg phi) s = Neg (subPred phi s)
subPred (Conj phi psi) s = Conj (subPred phi s) (subPred psi s)
subPred (Disj phi psi) s = Disj (subPred phi s) (subPred psi s)
subPred (Imp phi psi) s = Imp (subPred phi s) (subPred psi s)
subPred (Equiv phi psi) s = Equiv (subPred phi s) (subPred psi s)
subPred (All y phi) s
  | y == fst s = All y phi
  | not $ elem y (varsT $ snd s) = All y (subPred phi s)
  | otherwise = let z = makeNewVar $ All y phi
                in All z (subPred (subPred phi (y, VarP z)) s)
subPred (Ex y phi) s
  | y == fst s = Ex y phi
  | not $ elem y (varsT $ snd s) = Ex y (subPred phi s)
  | otherwise = let z = makeNewVar $ Ex y phi
                in Ex z (subPred (subPred phi (y, VarP z)) s)

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
interpTerm (VarP s) (_, l, _, _) = l s
interpTerm (Funct n args) (u, l, fctx, pctx) = fctx n (interpArgs args)
  where
    interpArgs args' = map (\t -> interpTerm t (u, l, fctx, pctx)) args'


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
examb "z" = 4
examb "w" = 15
examb _ = error "not defined!"

exuniverse :: Universe Int
exuniverse = [0..2^15]

exmodel :: Model Int
exmodel = (exuniverse, examb, exfctx, expctx)

-- Interpretación de predicados
interpPred :: Predicate -> Model a -> Bool
interpPred (Pred name args) (u, l, fctx, pctx) = case args of
                                  [] -> error "arity must be >= 1 !"
                                  xs -> pctx name (interpArgs args)
  where
    interpArgs args' = map (\t -> interpTerm t (u, l, fctx, pctx)) args'
interpPred (Neg p) m = not $ interpPred p m
interpPred (Conj p q) m = interpPred p m && interpPred q m
interpPred (Disj p q) m = interpPred p m || interpPred q m
interpPred (Imp p q) m = (not $ interpPred p m) || interpPred q m
interpPred (Equiv p q) m = interpPred p m == interpPred q m
interpPred (All x p) (u, l, fctx, pctx) = and [interpPred p (u, newAmb l val, fctx, pctx) | val <- u]
  where
    newAmb l' a' = (\y -> if y == x then a' else l' y)
interpPred (Ex x p) (u, l, fctx, pctx) = or [interpPred p (u, newAmb l val, fctx, pctx) | val <- u]
  where
    newAmb l' a' = (\y -> if y == x then a' else l' y)
