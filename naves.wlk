class Nave {
  var velocidad
  var direccion
  var combustible
  method acelerar(cantidad) {velocidad = (velocidad + cantidad).min(100000)}
  method desacelerar(cantidad) {velocidad = (velocidad - cantidad).max(0)}
  method irHaciaElSol() {direccion = 10}
  method escaparDelSol() {direccion = -10}
  method ponerseParaleloAlSol() {direccion = 0}
  method acercarseUnPocoAlSol() {direccion += 1}
  method alejarseUnPocoDelSol() {direccion -= 1}
  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
    }
  method cargarCombustible(cantidad) {combustible += cantidad}
  method descargarCombustible(cantidad) {combustible -= cantidad}
  method estaTranquila() = combustible >= 4000 and velocidad < 12000
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
    }
  method escapar()
  method avisar()
  method estaDeRelajo() = self.estaTranquila() and self.tenerPocaActividad()
  method tenerPocaActividad()
}

class NavesBaliza inherits Nave{
  var color = "azul"
  var cambios = 0
  method cambiarColorDeBaliza(colorNuevo) {
    color = colorNuevo
    cambios += 1
    }
  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }
  override method estaTranquila() = super() and color != "rojo"
  override method escapar() {self.irHaciaElSol()}
  override method avisar() {self.cambiarColorDeBaliza("rojo")}
  override method tenerPocaActividad() = cambios == 0
}

class NavesDePasajeros inherits Nave{
  var property pasajeros
  var comida = 0
  var bebida = 0
  var servidas = 0
  method cargarComida(cantidad) {comida += cantidad}
  method descargarComida(cantidad) {comida -= cantidad}
  method cargarBebida(cantidad) {bebida += cantidad}
  method descargarBebida(cantidad) {bebida -= cantidad}
  override method prepararViaje() {
    super()
    self.cargarComida(4 * pasajeros)
    self.cargarBebida(6 * pasajeros)
    self.acercarseUnPocoAlSol()
  }
  override method escapar() {self.acelerar(velocidad * 2)}
  override method avisar() {
    self.descargarBebida(2 * pasajeros)
    self.descargarComida(2* pasajeros)

    }
  override method tenerPocaActividad() = servidas <= 50
}

class NaveHospital inherits NaveDePasajeros{
  var property quirofanosPreparados = true
  override method estaTranquila() = super() and quirofanosPreparados == false
  override method recibirAmenaza(){
    super()
    self.quirofanosPreparados(true)
  }
}

class NavesDeCombate inherits Nave {
  const mensajesEmitidos = []
  var property ponerseVisible 
  var property ponerseInvisible
  var property desplegarMisiles
  var property replegarMisiles
  method estaInvisible() = ponerseInvisible
  method misilesDesplegados() = desplegarMisiles
  method emitirMensaje(mensaje) = mensajesEmitimos.add(mensaje)
  method primerMensaje() = mensajesEmitidos.first()
  method ultimoMensaje() = mensajesEmitidos.last()
  method esEscueta()
  method emitioMensaje() = !mensajesEmitidos.isEmpty()
  override method prepararViaje{
    super()
    self.acelerar(15000)
    self.emitirMensaje("saliendo en mision")
  }
  override method estaTranquila() = super() and self.misilesDesplegados() == false
  override method escapar() { 
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
    }
  override method avisar() {self.emitirMensaje("amenaza recibida")}
}

class NaveSigilosa inherits NaveDeCombate {
  override method estaTranquila() = super() and self.estaInvisible() == false
  override method recibirAmenaza() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}