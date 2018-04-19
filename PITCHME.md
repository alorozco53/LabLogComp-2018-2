## Laboratorio de Lógica Computacional, 2018-2

- [Noé Salomón Hernández Sánchez](mailto:no.hernan@gmail.com)
- [María del Carmen Sánchez Almanza](mailto:carmensanchez@ciencias.unam.mx)
- [Albert Manuel Orozco Camacho](mailto:alorozco53@ciencias.unam.mx)


---

# Asistente de pruebas _Coq_

---

**Ojo**: _Coq_ es una palabra *francesa* que significa

![gallo](assets/img/gallo.jpg)

---

### Coq...

<ul>
	<li class="fragment">
		Es un asistente de demostraciones formales. En la práctica, es posible
		tener _errores humanos_ al realizar una prueba: *coq* ayuda en evitar
		dichas erratas.
	</li>
	<li class="fragment">
		Por otro lado, se emplea para probar la correctud de objetos formales de
		gran complejidad:
	</li>
	<ul>
  		<li class="fragment">**Verificación de Software**</li>
  		<li class="fragment">
		[**El Teorema de los 4 colores**](https://www.ams.org/notices/200811/tx081101382p.pdf)
		</li>
	</ul>
</ul>

---

### Coq...

<ul>
	<li class="fragment">
		Posee tres lenguajes de _scripting_ para especificar
		_comandos_, _tácticas_ de demostración y _teorías_.
	</li>
	<li class="fragment">
		El más importante se llama **Gallina** y lo vamos a usar
		para especificar el cálcuo de predicados y proposiciones.
	</li>
</ul>

---

### Instalación

---

 - https://coq.inria.fr/download
 - https://github.com/coq/coq/releases/tag/V8.7.2
   (_instaladores para Windows y Mac OS X_)
 - `sudo apt-get install coq coqide` (_Linux_)
 - `brew install coq` (_Mac OS X_)

---

Esto debería instalar

- `coqtop`: una línea de comandos interactiva,
- `CoqIDE`: una interfaz gráfica **MUY** útil para nuestros menesteres.

---

### Recomendación

Si usas Emacs, revisar [ProofGeneral](https://proofgeneral.github.io),
un paquete para dicho editor que permite correr el asistente de pruebas
dentro del mismo.

---

# Hands on!!

---

```coq
Theorem my_first_proof__again : (forall A : Prop, A -> A).
Proof.
  intros A.
  intros proof_of_A.
  exact proof_of_A.
Qed.
```

---

Un _teorema_, _lema_ o _corolario_ en Coq consta de 3 conceptos:

- la declaración del enunciado a demostrar, asociándole un **nombre** único,
- la demostración: sucesión de **tácticas** que completan objetivos de acuerdo
  a lo establecido por el enunciado; esto inicia con la palabra reservada
  `Proof.` y finaliza con `Qed.`,
- _coq_ establece metas que deben ser cumplidas mediante la aplicación
  de una secuencia de tácticas.

---

### Tácticas y metas

Una **táctica** es el análogo a una regla de deducción natural. En _coq_ hay
un **contexto** de hipótesis que asumimos ciertas (DEMOSTRADAS) y hay una o
varias **metas** que han de ser logradas.

Por ejemplo, la táctica `apply <PROP> in <PROP>` correspondería a realizar
un _modus ponens_.

---

[![wumpus](assets/img/wumpus.jpg)](https://www.youtube.com/watch?v=tAy-uxBZBNQ)

---

### Bibliografía

- https://coq.inria.fr/tutorial-nahas
- https://coq.inria.fr/tutorial/1-basic-predicate-calculus
