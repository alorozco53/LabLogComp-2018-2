{- |
Module      :  PropositionalLogic
Maintainer  :  alorozco.patriot53@gmail.com
Author      :  AlOrozco53
Stability   :  experimental
Portability :  portable
Version     :  0.1
-}

module PropositionalLogic where


-- Cálculo de proposiciones
data Prop = VarP String            -- Variable proposicional
          | TTrue                  -- T
          | FFalse                 -- ⊥
          | Neg Prop               -- ¬ Φ
          | Disj Prop Prop         -- Φ ^ Ψ
          | Conj Prop Prop         -- Φ v Ψ
          | Imp Prop Prop          -- Φ -> Ψ
          | Equiv Prop Prop        -- Φ <-> Ψ
          deriving Show

-- instance Show Prop where
--   show TTrue = "True"

-- Tipo de dato de sustituciones
type Sub = String -> Prop

-- Ejemplo de sustitución
sub1 :: Sub
sub1 "p" = Equiv (VarP "q") FFalse
sub1 "q" = Neg TTrue
sub1 palabra = VarP palabra

-- Sustituciones
substitute :: Prop -> Sub -> Prop
substitute TTrue _ = TTrue
substitute FFalse _ = FFalse
substitute (Neg p) s = Neg (substitute p s)
subsitute (Equiv p q) s = Equiv (substitute p s) (substitute q s)

-- Tipo de dato de estado para variables proposicionales
-- Interpretamos como verdaderas, únicamente y exclusivamentelas variables contenidas
-- en la lista dada como estado
type State = [String]

-- Interpretaciones
interp :: Prop -> State -> Bool
interp TTrue _ = True
interp (Neg p) s = not $ interp p s

-- Dado un estado, ¿será un modelo para una fórmula?
model :: Prop -> State -> Bool
model = error "TBD"

-- Devuelve todas las variables contenidas en una fórmula dada
vars :: Prop -> [String]
vars TTrue = []
vars (Conj p q) = vars p ++ vars q

-- Genera la lista (conjunto) potencia de una lista
powerSet :: Eq a => [a] -> [[a]]
powerSet = error "TBD"

-- ¿Es tautología?
tautology :: Prop -> Bool
tautology = error "TBD"

-- Equivalencia de fórmulas
equivProp :: Prop -> Prop -> Bool
equivProp = error "TBD"

-- Consecuencia lógica
logicConsequence :: [Prop] -> Prop -> Bool
logicConsequence = error "TBD"
