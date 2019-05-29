import wollok.game.*

class Maiz {

	var property position
	var property image

	method teSembraronEn(posicion) {
		self.image("corn_baby.png")
		self.position(posicion)
		game.addVisual(self)
	}

	method teRegaron() {
	}

}

class Trigo {

	var property position
	var property estado

	method image() = estado.image()

	method teSembraronEn(posicion) {
		self.estado(estadoCero)
		self.position(posicion)
		game.addVisual(self)
	}

	method teRegaron() {
	}

}

class Tomaco {

	var property position
	var property image

	method teSembraronEn(posicion) {
		self.image("tomaco.png")
		self.position(posicion)
		game.addVisual(self)
	}

	method teRegaron() {
	}

}

object estadoCero {

	method image() = "wheat_0.png"

	method cambiarEstado() = estadoUno

}

object estadoUno {

	method image() = "wheat_1.png"

	method cambiarEstado() = estadoDos

}

object estadoDos {

	method image() = "wheat_2.png"

	method cambiarEstado() = estadoTres

}

object estadoTres {

	method image() = "wheat_3.png"

	method cambiarEstado() = estadoCero

}

