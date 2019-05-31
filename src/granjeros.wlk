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

	const limiteSuperior = (game.height() - 1)
	const limiteDerecho = (game.width() - 1)
	const limiteCero = 0
	var property elemento = hector // me pide inicializar
	var posicionDelElemento = elemento.position()

	method moverHaciaArriba(objeto) {
		self.elemento(objeto)
		self.moverElemento(self.posicionTodoAbajo(), posicionDelElemento.up(1))
	}

	method moverHaciaAbajo(objeto) {
		self.elemento(objeto)
		self.moverElemento(self.posicionTodoArriba(), posicionDelElemento.down(1))
	}

	method moverHaciaIzq(objeto) {
		self.elemento(objeto)
		self.moverElemento(self.posicionTodoDer(), posicionDelElemento.left(1))
	}

	method moverHaciaDer(objeto) {
		self.elemento(objeto)
		self.moverElemento(self.posicionTodoIzq(), posicionDelElemento.right(1))
	}

	method moverElemento(alBorde, normal) {
		if (self.estaEnLimitesDelTablero()) elemento.moverse(alBorde) else elemento.moverse(normal)
	}

	method posicionTodoAbajo() = game.at(posicionDelElemento.x(), limiteCero)

	method posicionTodoArriba() = game.at(posicionDelElemento.x(), limiteSuperior)

	method posicionTodoIzq() = game.at(limiteCero, posicionDelElemento.y())

	method posicionTodoDer() = game.at(limiteDerecho, posicionDelElemento.y())

	method estaEnLimitesDelTablero() = self.abajoDeTodo() or self.arribaDeTodo() or self.izqDeTodo() or self.derDeTodo()

	method abajoDeTodo() = posicionDelElemento.y() == limiteCero

	method arribaDeTodo() = posicionDelElemento.y() == limiteSuperior

	method izqDeTodo() = posicionDelElemento.x() == limiteCero

	method derDeTodo() = posicionDelElemento.x() == limiteDerecho

}

