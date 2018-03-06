{- |
Module      :  Practica1
Maintainer  :  alorozco.patriot53@gmail.com
Stability   :  experimental
Portability :  portable
Version     :  0.1
-}

module Practica1 where


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


-- Tipo de dato de sustituciones
type Sub = String -> Prop

-- Sustituciones
substitute :: Prop -> Sub -> Prop
substitute TTrue _ = TTrue
substitute FFalse _ = FFalse
substitute (VarP v) s = s v
substitute (Neg p) s = Neg $ substitute p s
substitute (Conj p q) s = Conj (substitute p s) (substitute q s)
substitute (Disj p q) s = Disj (substitute p s) (substitute q s)
substitute (Imp p q) s = Imp (substitute p s) (substitute q s)
substitute (Equiv p q) s = Equiv (substitute p s) (substitute q s)

sub1 :: Sub
sub1 "p" = Equiv (VarP "q") FFalse
sub1 "q" = TTrue
sub1 other = VarP other

-- Tipo de dato de estado para variables proposicionales
-- Interpretamos como verdaderas, únicamente y exclusivamentelas variables contenidas
-- en la lista dada como estado
type State = [String]

-- Interpretaciones
interp :: Prop -> State -> Bool
interp TTrue _ = True
interp FFalse _ = False
interp (VarP v) state = elem v state
interp (Neg p) state = not $ interp p state
interp (Conj p q) state = (interp p state) && (interp q state)
interp (Disj p q) state = (interp p state) || (interp q state)
interp (Imp p q) state = (not $ interp p state) || (interp q state)
interp (Equiv p q) state = interp (Conj (Imp p q) (Imp q p)) state


-- Dado un estado, ¿será un modelo para una fórmula?
model :: Prop -> State -> Bool
model p state = interp p state

-- Devuelve todas las variables contenidas en una fórmula dada
vars :: Prop -> [String]
vars p = trim $ case p of
                  TTrue -> []
                  FFalse -> []
                  (VarP v) -> [v]
                  (Neg p) -> vars p
                  (Conj p q) -> (vars p) ++ (vars q)
                  (Disj p q) -> (vars p) ++ (vars q)
                  (Imp p q) -> (vars p) ++ (vars q)
                  (Equiv p q) -> (vars p) ++ (vars q)
  where
    trim [] = []
    trim (x:xs)
      | elem x xs = trim xs
      | otherwise = trim xs ++ [x]

-- Genera la lista (conjunto) potencia de una lista
powerSet :: Eq a => [a] -> [[a]]
powerSet [] = [[]]
powerSet (x:xs) = (powerSet xs) ++ [x : ys | ys <- powerSet xs]

-- ¿Es tautología?
tautology :: Prop -> Bool
tautology p = let allStates = powerSet $ vars p
              in and [interp p s | s <- allStates]

-- Equivalencia de fórmulas
equivProp :: Prop -> Prop -> Bool
equivProp p q = tautology $ Equiv p q

-- Consecuencia lógica
logicConsequence :: [Prop] -> Prop -> Bool
logicConsequence gamma phi = let allVariables = trim $ foldl (++) [] (map vars gamma)
                             in let bigProp = foldl Conj TTrue gamma
                                in let trueStates = [s | s <- powerSet allVariables, model bigProp s]
                                   in case trueStates of
                                        [] -> True
                                        states -> and [model phi s | s <- states]
  where
    trim [] = []
    trim (x:xs)
      | elem x xs = trim xs
      | otherwise = trim xs ++ [x]

-- Otra versión de la consecuencia lógica
logicConsequence2 :: [Prop] -> Prop -> Bool
logicConsequence2 gamma phi = let bigProp = foldl Conj TTrue gamma
                              in tautology $ Imp bigProp phi
