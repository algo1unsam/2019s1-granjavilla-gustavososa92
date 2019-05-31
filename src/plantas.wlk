import wollok.game.*
import granjeros.*

class CosasDelTablero {

	var property position

	method image()

	method sePuedeCosechar() = false

	method teRegaron() {
		tablero.errorRegar()
	}

}

class Plantas inherits CosasDelTablero {

	method teCosecharon() {
		game.removeVisual(self)
	}

}

class Maiz inherits Plantas {

	var estado = estadoBebe

	override method image() = estado.image()

	method esAdulta() = estado.esAdulta()

	method valorVenta() = 150

	override method sePuedeCosechar() = self.esAdulta()

	override method teRegaron() {
		if (not self.esAdulta()) self.crece()
	}

	method crece() {
		estado = estadoAdulta
	}

}

class Trigo inherits Plantas {

	var estado = estadoCero

	method nuevoEstado(unEstado) {
		estado = unEstado
	}

	method valorVenta() = (self.nivel() - 1) * 100

	override method image() = estado.image()

	method nivel() = estado.nivel()

	override method sePuedeCosechar() = self.nivel() > 1

	override method teRegaron() {
		self.cambiarDeEstado()
	}

	method cambiarDeEstado() {
		self.nuevoEstado(estado.estadoSiguiente())
	}

}

class Tomaco inherits Plantas {

	override method image() = "tomaco.png"

	override method sePuedeCosechar() = true

	method valorVenta() = 80

	override method teRegaron() {
		self.moverHaciaArriba()
	}

	method moverHaciaArriba() {
		tablero.moverHaciaArriba(self)
	}

	method moverse(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

}

object estadoBebe {

	const property esAdulta = false

	method image() = "corn_baby.png"

}

object estadoAdulta {

	const property esAdulta = true

	method image() = "corn_adult.png"

}

object estadoCero {

	const property nivel = 0

	method image() = "wheat_0.png"

	method estadoSiguiente() = estadoUno

}

object estadoUno {

	const property nivel = 1

	method image() = "wheat_1.png"

	method estadoSiguiente() = estadoDos

}

object estadoDos {

	const property nivel = 2

	method image() = "wheat_2.png"

	method estadoSiguiente() = estadoTres

}

object estadoTres {

	const property nivel = 3

	method image() = "wheat_3.png"

	method estadoSiguiente() = estadoCero

}

