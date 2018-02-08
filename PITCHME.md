## Laboratorio de Lógica Computacional, 2018-2

- [Noé Salomón Hernández Sánchez](mailto:no.hernan@gmail.com)
- [María del Carmen Sánchez Almanza](mailto:carmensanchez@ciencias.unam.mx)
- [Albert Manuel Orozco Camacho](mailto:alorozco53@ciencias.unam.mx)


---

# (Revisión) de tipos de datos

---

### Forma general de los tipos de datos _suma_

```haskell
data TipoNuevo t_1 t_2 ... t_k = Constructor1 a_1_1 a_1_2 ... a_1_n
	                           | Constructor2 a_2_1 a_2_2 ... a_2_n
                               |      .
	                           |      .
	                           |      .
	                           | Constructor a_m_1 a_m_2 ... a_m_n
```

donde los `a_i_j` y `t_i_j` son cualquier tipo definido en Haskell.

---

# El paradigma funcional

---

![Church - Curry](assets/img/church-curry.png)

---

# ¡Haskell!

---

# Haskell: ~~¿Qué es?~~ **Recordando**

---

<ul>
	<li class="fragment">Lenguaje de programación _puramente_ funcional</li>
	<li class="fragment">Lenguaje _perezoso_</li>
	<li class="fragment">~~Tipado~~ Tipificado _estáticamente_</li>
	<li class="fragment">Usa _inferencia de tipos_</li>
	<li class="fragment">Basado en el [cálculo lambda](http://www.inf.fu-berlin.de/lehre/WS03/alpi/lambda.pdf)</li>
	<li class="fragment">[Razonamiento ecuacional](https://www.youtube.com/watch?v=c9wP9U9jWLs)</li>
</ul>
---

<img src="assets/img/le_fancy.jpg" alt="Le Fancy" width=400 height=600>

---

### Instalación

- Ubuntu y Debian
  ```bash
  sudo apt-get install haskell-platform
  ```
- `[ALTAMENTE RECOMENDADO]` Otras distribuciones de Linux: https://www.haskell.org/platform/linux.html#linux-generic
- Fedora
  ```bash
  sudo dnf install haskell-platform
  ```

---

- Mac OS X
  ```bash
  brew cask install haskell-platform
  ```
- Windows: https://www.haskell.org/platform/windows.html#windows

---

### Corriendo la interfaz interactiva

```bash
ghci
```
```haskell
GHCi, version 8.2.2: http://www.haskell.org/ghc/  :? for help
Prelude>
```

---

# Funciones

---

Sean $A$ y $B$ conjuntos, entonces el **producto cartesiano** $A$ por $B$
es la colección
$$A \times B =_{def} \\{(a, b)\ |\ a \in A, b\in B\\}.$$

<ul>
	<li class="fragment">Formalmente, se demuestra que $A \times B$ es un conjunto.</li>
</ul>

---

Sean $A$ y $B$ conjuntos; una **relación** entre $A$ y $B$ es un _subconjunto_
de $A \times B$.

---

Sean $A$ y $B$ conjuntos; una **función** $f$ con _dominio_ $A$ y _codominio_ $B$
es una **relación** entre $A$ y $B$ tal que
$$\forall\ x \in A, y \in A, x = y \implies f(x) = f(y)$$

---

# Tipos de datos primitivos

---

<span class="slide-title" >Tipos de datos primitivos</span>

```haskell
ghci> 2 + 15
17
ghci> 49 * 100
4900
ghci> 1892 - 1472
420
ghci> 5 / 2
2.5
ghci> div 5 2
2
ghci> True && True
True
ghci> False || True
True
ghci> not False
True
ghci> not (True && True)
False
```

---

# Listas

---

Una lista `l` de tipo `A` es

<ul>
	<li class="fragment">vacía, _i.e._, `[]`; o</li>
	<li class="fragment">es un objeto `x` de tipo `A`, concatenado con una lista `xs` de tipo `A`:
	`x : xs`
	</li>
</ul>

---

```haskell
Prelude> l = [1,3,4,5,6,7]
Prelude> l
[1,3,4,5,6,7]
Prelude> l ++ [0,4,5,8]
[1,3,4,5,6,7,0,4,5,8]
Prelude> a = "logica computacional"
Prelude> :t a
a :: [Char]
Prelude> 'X':a
"Xlogica computacional"
Prelude> a !! 5
'a'
Prelude> [3,2,1] > [2,1,0]
True
```

---

```haskell
Prelude> :t take
take :: Int -> [a] -> [a]
Prelude> take 5 "lambda "
"lambd"
Prelude> take 5 (cycle ["lambda "])
["lambda ","lambda ","lambda ","lambda ","lambda "]
Prelude> [1..25]
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
Prelude> ['A'..'Z']
"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
Prelude> [2,4..20]
[2,4,6,8,10,12,14,16,18,20]
```

---

### Listas por comprensión

$$C = \\{x^2\ |\ x\ \text{es un natural impar}\\}$$

---

```haskell
Prelude> [x^2 | x <- [0..10], mod x 2 /= 0]
[1,9,25,49,81]
take 15 [x^2 | x <- [0..], mod x 2 /= 0]
[1,9,25,49,81,121,169,225,289,361,441,529,625,729,841]
```

---

```haskell
boomBangs xs = [if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]
ghci> boomBangs [7..13]
["BOOM!","BOOM!","BANG!","BANG!"]
```

---

```haskell
myTail :: [a] -> [a]
myTail [] = []
myTail (x:xs) = xs
```
---

# Tipos de datos algebraicos

---

```haskell
data Bool = False | True
data Int = -2147483648 | -2147483647 | ... | -1 | 0 | 1 | 2 | ... | 2147483647
data [a] = [] | a:[a]
```

---

# Números naturales

---

```haskell
data Nat = Zero | Succ Nat  deriving Show
```

---

# Recursión

---

```haskell
fact :: Int -> Int
fact n
 | n <= 0 = 1
 | otherwise = (fact (n-1)) * n
```

---

### Ejercicios para puntos extras

- Dé una función que calcule el máximo común divisor de dos números enteros.
- Escriba un tipo de datos para representar un árbol binario de tipo genérico
  (`BinTree a`).
- Dada una lista `xs` de tipo `[Char]`, construya la lista de tipo `[BinTree Char]`
  que contiene todos los árboles binarios posibles con los elementos de `xs`
  y que están ordenados (es decir, árboles _de búsqueda binaria_).

---

### Bibliografía

- http://learnyouahaskell.com/chapters
- https://drive.google.com/file/d/17atMecWDziidvmdX60klMGBnQtOhTQQf/view?usp=sharing
