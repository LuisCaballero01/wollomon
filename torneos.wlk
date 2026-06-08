import wollok.mirror.*
import game.*
class Torneo{
    const property participantes = []

    method aprenderAtaqueMasivo(unAtaque){
        participantes.forEach({w => w.aprender(unAtaque)})
    }
    method batallaEntre(unWollomon,otroWollomon){
        if (!(participantes.contains(unWollomon) && participantes.contains(otroWollomon)))
            self.error("Alguno de los wollomones no es participante del torneo")
        else
            unWollomon.atacar(otroWollomon)
    }
    method batalla(){
        participantes.max({w => w.nivel()}).atacar(participantes.max({w => w.puntosDeSalud()}))
    }
    method darPocion() {
        participantes.forEach({w => if (w.puntosDeSalud() < 50) w.tomarPocionDe(20)})
    }
}