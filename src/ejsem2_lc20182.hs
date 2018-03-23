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

instance Show Tableau where
  show tableau = showAux tableau ""
    where
      showAux (Leaf props) acc = acc ++ show props
      showAux (AlphaBranch p q t) acc = acc ++ "Alpha\n" ++ acc ++ show p ++
                                        "\n" ++ acc ++ show q ++
                                        "\n" ++ showAux t acc
      showAux (BetaBranch t t') acc = let newacc = acc ++ "\t"
                                      in acc ++ "Beta" ++ "\n" ++ showAux t newacc ++
                                         "\n\n" ++ showAux t' newacc


-- Indica si la fórmula es una literal o no
isLiteral :: Prop -> Bool
isLiteral p = case p of
                VarP _ -> True
                Neg (VarP _) -> True
                Neg TTrue -> True
                Neg FFalse -> True
                TTrue -> True
                FFalse -> True
                _ -> False

-- Indica el tipo de la fórmula (alpha o beta)
propType :: Prop -> FormType
propType p = case p of
               Neg (Neg _) -> Alpha
               Conj _ _ -> Alpha
               Neg (Disj _ _) -> Alpha
               Neg (Imp _ _) -> Alpha
               Equiv _ _ -> Alpha
               Neg (Conj _ _) -> Beta
               Disj _ _ -> Beta
               Imp _ _ -> Beta
               Neg (Equiv _ _) -> Beta
               x -> error "formula is literal1!"

-- Dada una fórmula, la transforma a sub-fórmulas
-- según su tipo
transformProp :: Prop -> (FormType, (Prop, Prop))
transformProp p = let q = delDoubleNegs p
                  in let t = propType q
                     in (t, subFormulae q t)
  where
    subFormulae q' ty = case ty of
                          Alpha -> case q' of
                                     Conj phi psi -> (phi, psi)
                                     Neg (Disj phi psi) -> (Neg phi, Neg psi)
                                     Neg (Imp phi psi) -> (phi, Neg psi)
                                     Equiv phi psi -> (Imp phi psi, Imp psi phi)
                                     _ -> error "formula is literal2!"
                          Beta -> case q' of
                                    Neg (Conj phi psi) -> (Neg phi, Neg psi)
                                    Disj phi psi -> (phi, psi)
                                    Imp phi psi -> (Neg phi, psi)
                                    Neg (Equiv phi psi) -> (Neg $ Imp phi psi, Neg $ Imp psi phi)
                                    _ -> error "formula is literal3!"

-- Elimina dobles negaciones
delDoubleNegs :: Prop -> Prop
delDoubleNegs p' = case p' of
                     TTrue -> TTrue
                     FFalse -> FFalse
                     VarP v -> VarP v
                     Neg (Neg r) -> delDoubleNegs r
                     Neg r -> Neg $ delDoubleNegs r
                     Conj r s -> Conj (delDoubleNegs r) (delDoubleNegs s)
                     Disj r s -> Disj (delDoubleNegs r) (delDoubleNegs s)
                     Imp r s -> Imp (delDoubleNegs r) (delDoubleNegs s)
                     Equiv r s -> Equiv (delDoubleNegs r) (delDoubleNegs s)


-- Construye el tableau semántico para el conjunto de fórmulas dado
makeTableau :: [Prop] -> Tableau
makeTableau gamma
  | null gamma = error "empty formula set!"
  | and [isLiteral p | p <- gamma] = Leaf gamma
  | otherwise = makeTableau' (delExtras $ foldr Conj TTrue gamma) []
  where
    makeTableau' c acc = let ctx = delDoubleNegs c
                         in case isLiteral ctx of
                              True -> case acc of
                                        [] -> Leaf [ctx]
                                        xs -> let newacc = delExtras $ foldr Conj TTrue xs
                                              in AlphaBranch ctx newacc (makeTableau xs)
                              False -> case transformProp ctx of
                                         (Alpha, (alpha1, alpha2)) -> case isLiteral alpha1 of
                                                                        True -> case isLiteral alpha2 of
                                                                                  True -> case acc of
                                                                                            [] -> Leaf [alpha1, alpha2]
                                                                                            (x:xs) -> AlphaBranch alpha1 alpha2 (makeTableau' x xs)
                                                                                  False -> AlphaBranch alpha1 alpha2 (makeTableau' alpha2 acc)
                                                                        False -> case isLiteral alpha2 of
                                                                                   True -> AlphaBranch alpha1 alpha2 (makeTableau' alpha1 acc)
                                                                                   False -> let newacc = delExtras $ foldr Conj TTrue (alpha2:acc)
                                                                                            in AlphaBranch alpha1 newacc (makeTableau' alpha1 (alpha2:acc))
                                         (Beta, (beta1, beta2)) -> BetaBranch (makeTableau' beta1 acc) (makeTableau' beta2 acc)
    delExtras prop = case prop of
                       Conj TTrue q -> delExtras q
                       Conj q TTrue -> delExtras q
                       VarP s -> VarP s
                       TTrue -> TTrue
                       FFalse -> FFalse
                       Neg q -> Neg $ delExtras q
                       Conj q s -> Conj (delExtras q) (delExtras s)
                       Disj q s -> Disj (delExtras q) (delExtras s)
                       Imp q s -> Imp (delExtras q) (delExtras s)
                       Equiv q s -> Equiv (delExtras q) (delExtras s)


-- Dado un Tableau, devuelve una lista de listas de todas las literales por rama
literalsBranches :: Tableau -> [[Prop]]
literalsBranches tableau = litsAux tableau [[]]
  where
    litsAux (Leaf lits) acc = [lits ++ a | a <- acc]
    litsAux (AlphaBranch p q t) acc = let l = [r | r <- [p, q], isLiteral r]
                                      in litsAux t [l ++ a | a <- acc]
    litsAux (BetaBranch t t') acc = litsAux t acc ++ litsAux t' acc

-- Dadas dos literales, decide si son complementarias o no
compLiterals :: Prop -> Prop -> Bool
compLiterals (VarP s) q = case q of
                            Neg q' -> case q' of
                                        VarP v -> s == v
                                        _ -> False
                            _ -> False
compLiterals q (VarP s) = case q of
                            Neg q' -> case q' of
                                        VarP v -> s == v
                                        _ -> False
                            _ -> False
compLiterals TTrue q = case delDoubleNegs q of
                         FFalse -> True
                         Neg (TTrue) -> True
                         _ -> False
compLiterals FFalse q = case delDoubleNegs q of
                         TTrue -> True
                         Neg (FFalse) -> True
                         _ -> False
compLiterals q TTrue = case delDoubleNegs q of
                         FFalse -> True
                         Neg (TTrue) -> True
                         _ -> False
compLiterals q FFalse = case delDoubleNegs q of
                         TTrue -> True
                         Neg (FFalse) -> True
                         _ -> False
compLiterals _ _ = False

-- Decide si el argumento lógico dado es correcto o no, usando el método del
-- tableau semántico
correctTableau :: [Prop] -> Prop -> Bool
correctTableau gamma phi = let biggamma = gamma ++ [Neg phi]
                           in let tableau = makeTableau biggamma
                              in and [closed branch | branch <- literalsBranches tableau]
  where
    closed b = or [compLiterals l l' | l <- b, l' <- b]
