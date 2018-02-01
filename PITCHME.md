## Laboratorio de Lógica Computacional, 2018-2

- [Noé Salomón Hernández Sánchez](mailto:no.hernan@gmail.com)
- [María del Carmen Sánchez Almanza](mailto:carmensanchez@ciencias.unam.mx)
- [Albert Manuel Orozco Camacho](mailto:alorozco53@ciencias.unam.mx)


---

# Paradigmas de programación

<ul>
	<li class="fragment">Imperativo</li>
	<li class="fragment">Orientado a objetos</li>
	<li class="fragment">_Declarativo_</li>
	<ul>
  		<li class="fragment">**Funcional**</li>
  		<li class="fragment">**Lógico**</li>
	</ul>
	<li class="fragment">Multi-paradigma</li>
</ul>

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

# Tipos de datos primitivos

---

<span class="menu-title" >Tipos de datos primitivos</span>

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

# Tipos de datos algebraicos

---

# Números naturales

---

# *Turbo* Recursión

---

