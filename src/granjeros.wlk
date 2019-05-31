import wollok.game.*
import plantas.*

object hector {

	var property position = game.at(5, 5)
	const plantasCosechadas = []
	var dineroJuntado = 0

	method dinero() = dineroJuntado

	method vaciarPlantasCosechadas() {
		plantasCosechadas.clear()
	}

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

	method cosasEnMismaPosicion() = game.colliders(self) // me da todos menos hector

//--------------------------------------------------------------------------
	method regar() { // ojo que teRegaron() se lo envia a todos los colliders
		if (self.lugarNoEstaOcupado()) tablero.errorRegar() else {
			self.cosasEnMismaPosicion().forEach({ e => e.teRegaron()})
		}
	}

	method intentarCosechar() {
		self.cosasEnMismaPosicion().forEach({ e =>
			if (e.sePuedeCosechar()) { // ojo que sePuedeCosechar() se lo envia a todos los colliders
				plantasCosechadas.add(e)
				e.teCosecharon()
			}
		})
	}

//----------------------------------------------------------------
	method cosechar() {
		if (self.lugarNoEstaOcupado()) tablero.errorCosechar() else {
			self.intentarCosechar()
		}
	}

	method valorVentaPlantas() = plantasCosechadas.sum({ p => p.valorVenta() })

	method cantidadDePlantasParaVender() = plantasCosechadas.size()

	method cosechoPlantas() = self.cantidadDePlantasParaVender() > 0

	method vender() {
		if (self.cosechoPlantas()) {
			dineroJuntado += self.valorVentaPlantas()
			self.vaciarPlantasCosechadas()
		} else tablero.errorVender()
	}

	method moverse(nuevaPosicion) {
		self.position(nuevaPosicion)
	}

	method cuantoTenes() {
		game.say(self, "Junte " + self.dinero() + " monedas, y tengo " + self.cantidadDePlantasParaVender() + " plantas para vender")
	}

}

object tablero {

	const limiteSuperior = (game.height() - 1)
	const limiteDerecho = (game.width() - 1)
	const limiteCero = 0

	method errorRegar() {
		self.error("no tengo nada para regar")
	}

	method errorCosechar() {
		self.error("no tengo nada para cosechar")
	}

	method errorVender() {
		self.error("no tengo Plantas para vender")
	}

	method moverHaciaArriba(objeto) {
		game.height(15)
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

	method abajoDeTodo(posicion) = posicion.y() == limiteCero

	method arribaDeTodo(posicion) = posicion.y() == limiteSuperior

	method izqDeTodo(posicion) = posicion.x() == limiteCero

	method derDeTodo(posicion) = posicion.x() == limiteDerecho

}

