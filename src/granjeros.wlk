import wollok.game.*
import plantas.*

object hector {

	var property position = game.at(5, 5)

	method image() = "player.png"

	method plantarMaiz() {
		self.plantar(new Maiz())
	}

	method plantarTrigo() {
		self.plantar(new Trigo())
	}

	method plantarTomaco() {
		self.plantar(new Tomaco())
	}

	method plantar(planta) {
		if (self.lugarNoEstaOcupado()) {
			planta.position(self.position())
			game.addVisual(planta)
		}
	}

	method lugarNoEstaOcupado() = self.cosasEnMismaPosicion().isEmpty()

	method cosasEnMismaPosicion() = game.colliders(self)

	method regar() {
		if (self.lugarNoEstaOcupado()) self.error("no tengo nada para regar") else {
			self.cosasEnMismaPosicion().forEach({ e => e.teRegaron()})
		}
	}

	method moverHaciaArriba() {
		tablero.moverHaciaArriba(self)
	}

	method moverHaciaAbajo() {
		tablero.moverHaciaAbajo(self)
	}

	method moverHaciaIzq() {
		tablero.moverHaciaIzq(self)
	}

	method moverHaciaDer() {
		tablero.moverHaciaDer(self)
	}

	method moverse(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

}

object tablero {

	const limiteSuperior = 9 // (game.height() - 1)
	const limiteDerecho = 17 // (game.width() - 1)
	const limiteCero = 0

	method moverHaciaArriba(objeto) {
		self.moverElemento(objeto, self.arribaDeTodo(objeto.position()), self.posicionTodoAbajo(objeto.position()), objeto.position().up(1))
	}

	method moverHaciaAbajo(objeto) {
		self.moverElemento(objeto, self.abajoDeTodo(objeto.position()), self.posicionTodoArriba(objeto.position()), objeto.position().down(1))
	}

	method moverHaciaIzq(objeto) {
		self.moverElemento(objeto, self.izqDeTodo(objeto.position()), self.posicionTodoDer(objeto.position()), objeto.position().left(1))
	}

	method moverHaciaDer(objeto) {
		self.moverElemento(objeto, self.derDeTodo(objeto.position()), self.posicionTodoIzq(objeto.position()), objeto.position().right(1))
	}

	method moverElemento(objeto, condicion, alBorde, normal) {
		if (condicion) objeto.moverse(alBorde) else objeto.moverse(normal)
	}

	method posicionTodoAbajo(posicion) = game.at(posicion.x(), limiteCero)

	method posicionTodoArriba(posicion) = game.at(posicion.x(), limiteSuperior)

	method posicionTodoIzq(posicion) = game.at(limiteCero, posicion.y())

	method posicionTodoDer(posicion) = game.at(limiteDerecho, posicion.y())

//	method estaEnLimitesDelTablero(posicion) = self.abajoDeTodo(posicion) or self.arribaDeTodo(posicion) or self.izqDeTodo(posicion) or self.derDeTodo(posicion)
	method abajoDeTodo(posicion) = posicion.y() == limiteCero

	method arribaDeTodo(posicion) = posicion.y() == limiteSuperior

	method izqDeTodo(posicion) = posicion.x() == limiteCero

	method derDeTodo(posicion) = posicion.x() == limiteDerecho

}

