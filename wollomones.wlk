class Wollomon{
    const property ataques = []
    var nivel
    var puntosDeSalud = 200

    method puntosDeSalud() = puntosDeSalud
    method nivel() = nivel

    method puedeAtacar() = puntosDeSalud>10
    method daño()

    method aprender(unAtaque){
        ataques.add(unAtaque)
    }

    method atacar(unWollokmon){
        if (self.puedeAtacar()){
            unWollokmon.recibirAtaqueDe(self)
            self.sufrirEfectos()
        }
    }
    method sufrirEfectos()
    method recibirAtaqueDe(unWollokmon){
        puntosDeSalud = 0.max(puntosDeSalud - unWollokmon.daño())
    }
    method tomarPocionDe(cant){
        puntosDeSalud += cant
    }
}

class Ataque{
    const property dañoQueHace
}

class Bicho inherits Wollomon{
    override method daño() = ataques.sum({a => a.dañoQueHace()})

    override method sufrirEfectos(){
        nivel += 10
    }
}

class Dragon inherits Wollomon{
    const property fuegoInterior
    
    override method puedeAtacar() = super() && fuegoInterior>20
    override method daño() = fuegoInterior + self.dañoPorAtaqueMasFuerte()
    method dañoPorAtaqueMasFuerte() = if (!ataques.isEmpty()) ataques.max({a => a.dañoQueHace()}).dañoQueHace() else 0

    override method sufrirEfectos(){
        nivel += fuegoInterior.div(2)
    }
}

class Electrico inherits Wollomon{
    method estaCargado() = clima.humedad() > 97
    override method puedeAtacar() = super() && self.estaCargado()

    override method daño() = if (self.estaCargado()) ataques.first().dañoQueHace() else 0

    override method recibirAtaqueDe(unWollokmon){
        super(unWollokmon)
        nivel -= 1
    }

    override method sufrirEfectos(){
        if (self.estaCargado())
            nivel += 20
    }
}
object clima{
    var property humedad = 50
}

class Legendario inherits Dragon{
    const insignia

    override method daño() = super() + insignia.potenciadorPara(self)
}
object insigniaRoja{
    method potenciadorPara(unDragon) = if (unDragon.fuegoInterior()>20) 10 else 0
}
object insigniaAzul{
    method potenciadorPara(unDragon) = 8
}
object insigniaVerde{
    method potenciadorPara(unDragon) = 0
}