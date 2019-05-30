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
		if (self.lugarNoEstaOcupado()) planta.teSembraronEn(self.position())
	}

	method lugarNoEstaOcupado() = self.cosasEnMismaPosicion().isEmpty()

	method cosasEnMismaPosicion() = game.colliders(self)

	method regar() {
		if (self.lugarNoEstaOcupado()) self.error("no tengo nada para regar") else {
			self.cosasEnMismaPosicion().forEach({ e => e.teRegaron()})
		}
	}

}

