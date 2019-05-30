import wollok.game.*

class Maiz {

	var property position
	var estado = estadoBebe

	method image() = estado.image()

	method esAdulta() = estado.esAdulta()

	method teSembraronEn(posicion) {
		self.position(posicion)
		game.addVisual(self)
	}

	method teRegaron() {
		if (not self.esAdulta()) self.crece()
	}

	method crece() {
		estado = estadoAdulta
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

class Trigo {

	var property position
	var estado = estadoCero

	method nuevoEstado(unEstado) {
		estado = unEstado
	}

	method image() = estado.image()

	method teSembraronEn(posicion) {
		self.position(posicion)
		game.addVisual(self)
	}

	method teRegaron() {
		self.nuevoEstado(estado.estadoSiguiente())
	}

}

object estadoCero {

	method image() = "wheat_0.png"

	method estadoSiguiente() = estadoUno

}

object estadoUno {

	method image() = "wheat_1.png"

	method estadoSiguiente() = estadoDos

}

object estadoDos {

	method image() = "wheat_2.png"

	method estadoSiguiente() = estadoTres

}

object estadoTres {

	method image() = "wheat_3.png"

	method estadoSiguiente() = estadoCero

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

