module Ejemplos where


data Nat = Zero | Succ Nat  deriving Show

data BinTree a = BTNil
               | BTBranch a (BinTree a) (BinTree a)
               deriving Eq

instance Show a => Show (BinTree a) where
  show btree = showAux btree ""
    where
      showAux BTNil acc = "Nil"
      showAux (BTBranch r lchild rchild) acc = let newacc = acc ++ "\t"
                                               in "Branch " ++ show r ++
                                                  "\n" ++ newacc ++ showAux rchild newacc ++
                                                  "\n" ++ newacc ++ showAux lchild newacc

-- | Hojas de árbol binario
leaves :: BinTree a -> [a]
leaves BTNil = []
leaves (BTBranch r BTNil BTNil) = [r]
leaves (BTBranch _ BTNil rchild) = leaves rchild
leaves (BTBranch _ lchild BTNil) = leaves lchild
leaves (BTBranch _ lchild rchild) = (leaves lchild) ++ (leaves rchild)


insertBST :: (Ord a) => a -> BinTree a -> BinTree a
insertBST x BTNil = BTBranch x BTNil BTNil
insertBST x (BTBranch r lchild rchild)
  | x <= r = BTBranch r (insertBST x lchild) rchild
  | otherwise = BTBranch r lchild (insertBST x rchild)
