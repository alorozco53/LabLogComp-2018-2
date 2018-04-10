# Práctica 2

## Ejemplo de implementación de la semántica de la lógica de predicados.

A continuación ejemplificaremos el uso de la implementación sugerida en
esta práctica mediante la definición de números naturales.

Tomando como universo al conjunto de los números naturales, implementamos un **universo**:
```haskell
exmodel :: Universe Int
exmodel = [0..2^15]
```
(Ojo: tomamos un subconjunto finito para asegurarnos que la validez de fórmulas pueda ser calculada.)

Ahora definimos un un **contexto de funciones**, el cual servirá para definir _operadores_ entre números
naturales. En este caso mostramos únicamente la implementación para la _suma_ y el _producto_; además,
las constantes serán las cadenas formadas únicamente por símbolos numéricos (`[0-9]`), por lo que su
interpretación se reduce a transformar dicha cadena en el `Int` equivalente
(ver la función [read](https://www.haskell.org/hoogle/?hoogle=Read)).
```haskell
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
```

Para el **contexto de predicados**, mostramos únicamente la implementación para los operadores
_menor que_ e _igual_.
```haskell
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
```

Definimos, también, un **ambiente de variables** en el cual se relacionan `String`s con valores
concretos del universo (a saber, `Int`).
```haskell
examb :: Ambient Int
examb "x" = 1
examb "y" = 69
examb "z" = 4
examb "w" = 15
examb _ = error "not defined!"
```

De esta manera, nuestro modelo ejemplo es la siguiente 4-tupla:
```haskell
exmodel :: Model Int
exmodel = (exuniverse, exambient, exfctx, expctx)
```

Ahora observemos la firma de la función `interpTerm`:
```haskell
interpTerm :: Term -> Model a -> a
```
De acuerdo a `exmodel`, observamos que el tipo de lo que devuelve `interpTerm`
debe ser `Int`, por lo que se deben de poder hacer las siguientes interpretaciones:
```haskell
*Practica2> interpTerm (Funct "sum" [VarP "z", Funct "3" []]) exmodel
7
*Practica2> interpTerm (Funct "prod" [VarP "y", Funct "2" []]) exmodel == 138
True
*Practica2> interpTerm (Funct "prod" [Funct "sum" [VarP "x", VarP "y"], Funct "2" []]) exmodel
140
```

Finalmente, los siguientes son algunos predicados que se pueden implementar usando
la función `interpPred`:

- _Para cualquier natural x, siempre se cumple que x + z < x + y (de acuerdo a las variables de_ `examb`_)_.
  ```haskell
  *Practica2> interpPred (All "x" (Pred "less" [Funct "sum" [VarP "x", VarP "z"], Funct "sum" [VarP "x", VarP "y"]])) exmodel
  True
  ```
- _Para cualquier natural m, existe otro n, que no es el cero, tal que n < m_.
  ```haskell
  *Practica2> interpPred (Ex "n" (All "m" (Imp (Neg $ Pred "equal" [VarP "n", Funct "0" []]) (Pred "less" [VarP "n", VarP "m"])))) exmodel
  True
  ```
