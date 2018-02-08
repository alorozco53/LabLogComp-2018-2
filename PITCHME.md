## Laboratorio de Lógica Computacional, 2018-2

- [Noé Salomón Hernández Sánchez](mailto:no.hernan@gmail.com)
- [María del Carmen Sánchez Almanza](mailto:carmensanchez@ciencias.unam.mx)
- [Albert Manuel Orozco Camacho](mailto:alorozco53@ciencias.unam.mx)


---

# (Revisión) de tipos de datos

---

### Forma general de los tipos de datos _suma_

```haskell
data TipoNuevo t_1 t_2 ... t_k = Constructor_1 a_1_1 a_1_2 ... a_1_n
	                           | Constructor_2 a_2_1 a_2_2 ... a_2_n
                               |      .
                               |      .
                               |      .
                               | Constructor_m a_m_1 a_m_2 ... a_m_n
```

donde los `a_i_j` y `t_i_j` son cualquier tipo definido en Haskell.

---

### Árboles binarios

```haskell
data BinTree a = BTNil
               | BTBranch a (BinTree a) (BinTree a)
               deriving (Eq, Show)
```

---

Lista de todas las hojas del árbol binario

```haskell
leaves :: BinTree a -> [a]
leaves BTNil = []
leaves (BTBranch r BTNil BTNil) = [r]
leaves (BTBranch _ BTNil rchild) = leaves rchild
leaves (BTBranch _ lchild BTNil) = leaves lchild
leaves (BTBranch _ lchild rchild) = (leaves lchild) ++ (leaves rchild)
```

---

Cuenta el número de hojas en el árbol dado

```haskell
nLeaves :: BinTree a -> Nat
nLeaves tree = intToNat $ length $ leaves tree
```

---

Inserción _a la_ **árbol de búsqueda binaria**

```haskell
insertBST :: (Ord a) =>  a -> BinTree a -> BinTree a
insertBST x BTNil = BTBranch x BTNil BTNil
insertBST x (BTBranch r lchild rchild)
  | x <= r = BTBranch r (insertBST x lchild) rchild
  | otherwise = BTBranch r lchild (insertBST x rchild)
```

---


Pero, ¿qué pasó aquí arriba?

---

- Composición de funciones
- `($) :: (a -> b) -> a -> b` (agrupamiento de expresiones a la derecha)

---

No me gusta cómo Haskell imprime las cosas...

# ¿Cómo _personalizar_ la impresión de tipos de datos?

---

```haskell
instance Show a => Show TipoNuevo where
  show Constructor_1 ... =
  show Constructor_2 ... =
  .
  .
  .
  show Constructor_m
```

Es decir, el `TipoNuevo` se hace instancia de la clase `Show`, que es la
responsable de realizar el **efecto secundario** de imprimir en pantalla.
Finalmente, se define la función `show` cazando todos los patrones del tipo nuevo.

---

### Impresión _elegante_ de árboles binarios

```haskell
instance Show a => Show (BinTree a) where
  show btree = showAux btree ""
    where
      showAux BTNil acc = "Nil"
      showAux (BTBranch r lchild rchild) acc = let newacc = acc ++ "\t"
                                               in "Branch " ++ show r ++
                                                  "\n" ++ newacc ++ showAux rchild newacc ++
                                                  "\n" ++ newacc ++ showAux lchild newacc
```
---

# Ejercicios para puntos extras

---

- Dé una función que calcule el máximo común divisor de dos números enteros.
- Escriba un tipo de datos para representar un árbol binario de tipo genérico
  (`BinTree a`).
- Dada una lista `xs` de tipo `[Char]`, construya la lista de tipo `[BinTree Char]`
  que contiene todos los árboles binarios posibles con los elementos de `xs`
  y que están ordenados (es decir, árboles _de búsqueda binaria_).

---

- Implementar recorridos `preorder`, `inorder` y `postorder`
- Desarrollar un algoritmo de ordenamiento basado en árboles de búsqueda binaria.
- Implementar búsqueda binaria en una lista ordenada

---

### Bibliografía

- http://learnyouahaskell.com/chapters
- https://drive.google.com/file/d/17atMecWDziidvmdX60klMGBnQtOhTQQf/view?usp=sharing
