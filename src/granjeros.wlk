import wollok.game.*
import plantas.*

object hector {

	var property position = game.at(5, 5)

	method image() = "player.png"

	method moverse(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

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

}

object tablero {

	const limiteSuperior = game.height() - 1
	const limiteDerecho = game.width() - 1
	const limiteCero = 0

	method moverHaciaArriba(objeto) {
	}

	method estaEnLimitesDelTablero(posicion) {}

	method posicionTodoAbajo(posicion) = game.at(posicion.x(), limiteCero)

	method posicionTodoArriba(posicion) = game.at(posicion.x(), limiteSuperior)

	method posicionTodoIzq(posicion) = game.at(limiteCero, posicion.y())

	method posicionTodoDer(posicion) = game.at(limiteDerecho, posicion.y())

}

