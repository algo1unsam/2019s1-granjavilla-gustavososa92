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
		if (self.noHayUnaPlanta()) planta.teSembraronEn(self.position())
	}

	method noHayUnaPlanta() = self.plantasEnMismaPosicion().isEmpty()

	method plantasEnMismaPosicion() = game.colliders(self)

	method regar() {
		if (self.noHayUnaPlanta()) game.say(self,"no tengo nada para regar")
		self.plantasEnMismaPosicion().get(0).teRegaron()
	}

}

