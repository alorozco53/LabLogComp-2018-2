{- |
Module      :  Ejsem2
Maintainer  :  alorozco.patriot54@gmail.com
Stability   :  experimental
Portability :  portable
Version     :  0.1
-}

module Ejsem2 where


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

-- | Tableaux Semánticos para la lógica proposicional

-- Clasificación de fórmulas
data FormType = Alpha | Beta  deriving (Show, Eq)

-- Tipo de datos que codifica el tableau
data Tableau = Leaf [Prop]
             | AlphaBranch Prop Prop Tableau
             | BetaBranch Tableau Tableau
             deriving Show

-- Indica si la fórmula es una literal o no
isLiteral :: Prop -> Bool
isLiteral = error "TBD"

-- Indica el tipo de la fórmula (alpha o beta)
propType :: Prop -> FormType
propType = error "TBD"

-- Dada una fórmula, la transforma a sub-fórmulas
-- según su tipo
transformProp :: Prop -> (FormType, (Prop, Prop))
transformProp = error "TBD"

-- Construye el tableau semántico para el conjunto de fórmulas dado
makeTableau :: [Prop] -> Tableau
makeTableau = error "TBD"

-- Dado un Tableau, devuelve una lista de listas de todas las literales por rama
literalsBranches :: Tableau -> [[Prop]]
literalsBranches = error "TBD"

-- Dadas dos literales, decide si son complementarias o no
compLiterals :: Prop -> Prop -> Bool
compLiterals = error "TBD"

-- Decide si el argumento lógico dado es correcto o no, usando el método del
-- tableau semántico
correctTableau :: [Prop] -> Prop -> Bool
correctTableau = error "TBD"
