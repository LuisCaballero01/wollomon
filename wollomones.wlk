class Wollomon{
// atributos generales
    const property ataques = [] //property para tests
    var nivel
    var puntosDeSalud = 200
//
//comportamientos generales
    method puntosDeSalud() = puntosDeSalud
    method nivel() = nivel
    method daño()
    method puedeAtacar() = puntosDeSalud>10
    
    method aprender(unAtaque){
        ataques.add(unAtaque)
    }
    method atacar(unWollokmon){
        if (self.puedeAtacar()){
            unWollokmon.recibirAtaqueDe(self)
            self.sufrirEfectosDeAtacar()
        }
    }
    method recibirAtaqueDe(unWollokmon){
        puntosDeSalud = 0.max(puntosDeSalud - unWollokmon.daño())
    }
    method sufrirEfectosDeAtacar()
    method tomarPocionDe(cant){
        puntosDeSalud += cant
    }
//
}

class Ataque{
    const property dañoQueHace
}

class Bicho inherits Wollomon{
    override method daño() = ataques.sum({a => a.dañoQueHace()})

    override method sufrirEfectosDeAtacar(){
        nivel += 10
    }
}

class Dragon inherits Wollomon{
//Atributo propio
    const property fuegoInterior
//  
    override method daño() = fuegoInterior + self.dañoPorAtaqueMasFuerte()
    override method puedeAtacar() = super() && fuegoInterior>20

    override method sufrirEfectosDeAtacar(){
        nivel += fuegoInterior.div(2)
    }
//Comportamiento propio
    method dañoPorAtaqueMasFuerte() = if (!ataques.isEmpty()) ataques.max({a => a.dañoQueHace()}).dañoQueHace() else 0
}

class Electrico inherits Wollomon{
    override method daño() = if (self.estaCargado() && !ataques.isEmpty()) ataques.first().dañoQueHace() else 0
    override method puedeAtacar() = super() && self.estaCargado()

    override method recibirAtaqueDe(unWollokmon){
        super(unWollokmon)
        nivel -= 1
    }
    override method sufrirEfectosDeAtacar(){
        if (self.estaCargado())
            nivel += 20
    }
//comportamiento propio
    method estaCargado() = clima.humedad() > 97
}

//Objeto específico para los tipo electrico
object clima{
//No especifica el cambio en la humedad, property de una por comodidad.
    var property humedad = 50
}

class Legendario inherits Dragon{
//Atributo propio
    const insignia
//
    override method daño() = super() + insignia.potenciadorPara(self)
}

//Objetos polimórfimos específicos para los tipo legendario
object insigniaRoja{
    method potenciadorPara(unDragon) = if (unDragon.fuegoInterior()>20) 10 else 0
}
object insigniaAzul{
    method potenciadorPara(unDragon) = 8
}
object insigniaVerde{
    method potenciadorPara(unDragon) = 0
}