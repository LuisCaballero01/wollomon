# **⚔️ Wollomones: Batallas y Torneos**

Este documento describe las especificaciones para el proyecto Wollomon, un sistema de batallas y torneos entre criaturas fantásticas.

---

## **🐾 Wollomon**

Los Wollomones son las criaturas que participan en las batallas del Torneo.

### **Atributos Generales**

Todos los Wollomones tienen:

- **`nivel`**: Un valor numérico que representa su experiencia.
- **`puntos de salud (PS)`**: Comienzan con 200 PS.
- **`ataques`**: Los ataques que conocen.

### **Ataques**

Los ataques se caracterizan por el **valor del daño** que generan.

### **Comportamiento General**

- Un Wollomon puede atacar si tiene **más de 10 puntos de salud**.
- Cuando un Wollomon aprende un ataque, este se agrega a su colección de ataques.

---

## **📊 Tipos de Wollomon**

Los Wollomones **siempre** pertenecen a un tipo. Por ahora conocemos cuatro tipos, cada uno con comportamientos únicos, pero podrían sumarse nuevos tipos en el futuro.

### **🐛 1. Wollomon tipo Bicho**

- **Daño que efectúa**: La **suma** de los daños de todos sus ataques.

---

### **🐉 2. Wollomon tipo Dragón**

- **Atributo especial**: `fuego interior`.
- **Puede atacar**: Si cumple la condición general (PS > 10) y además su `fuego interior` es **mayor a 20**.
- **Daño que efectúa**: El valor de su `fuego interior` + el daño de su **mejor ataque** (aquel que genera mayor daño).

---

### **⚡ 3. Wollomon tipo Eléctrico**

- Todos los Wollomones Eléctricos dependen de las condiciones climáticas. Se consideran `cargados` cuando el valor de la humedad del ambiente es **mayor a 97**.
- **Puede atacar**: Si cumple la condición general (PS > 10) y además está `cargado`.
- **Daño que efectúa**:
  - Si está `cargado`: Aplica el daño del **primer ataque** de su lista.
  - Si no está `cargado`: No aplica ningún daño (0).

---

### **✨ 4. Wollomon tipo Legendario**

Los Legendarios son un tipo especial de **Dragón**, pero poseen una `insignia` que potencia su ataque.

- **Daño que efectúa**: El daño definido para los Dragón, más un aumento proporcionado por su `insignia`.

#### **Tipos de Insignias**

- **🔴 Insignia Roja**:
  - Si `fuego interior` > 20: Aumenta el daño en **10**.
  - De lo contrario: Aumenta el daño en **5**.
- **🔵 Insignia Azul**: Aumenta el daño en **8** siempre.
- **🟢 Insignia Verde**: No aumenta el daño a efectuar.

---

## **📋 Requerimientos (Wollomon)**

- Saber si un Wollomon puede atacar o no.
- Obtener el daño que efectúa un Wollomon al atacar.
- Hacer que un Wollomon aprenda un nuevo ataque.

---

## **🏁 Checkpoint 1**

#### ✅ Primer _commit_ al repositorio.

Aquí se definen 2 casos de prueba concretos para validar la lógica principal.

### **🧪 Lógica de Tipos (Legendario con Insignia)**

**Objetivo:** Validar el cálculo de daño de un Wollomon Legendario, que combina la lógica del Dragón con la de la Insignia Roja.

> **📌 Dado:**
>
> - Un Wollomon Legendario, **`Drako`**, con:
>   - `nivel: 20`
>   - `fuegoInterior: 25`
>   - `insignia: Roja`
>   - `ataques: [Ataque(daño: 10), Ataque(daño: 40)]` (su mejor ataque es 40)
>
> **⚙️ Cuando:**
>
> - Se calcula el daño que efectúa `Drako`.
>
> **✅ Entonces (Resultado):**
>
> - **Verificar** Que el daño total debe ser **75**.
> - _(Cálculo: 25 (fuego) + 40 (mejor ataque) + 10 (bono Insignia Roja por fuego > 20))_

---

### **🧪 Lógica de Tipos (Bicho y Suma de Ataques)**

**Objetivo:** Validar el cálculo de daño de un Wollomon Bicho, que debe ser la suma de _todos_ sus ataques.

> **📌 Dado:**
>
> - Un Wollomon Bicho, **`Katerpi`**, con:
>   - `nivel: 15`
>   - `ataques: [Ataque(daño: 5), Ataque(daño: 10), Ataque(daño: 2)]`
>
> **⚙️ Cuando:**
>
> - Se calcula el daño que efectúa `Katerpi`.
>
> **✅ Entonces (Resultado):**
>
> - **Verificar** que el daño total debe ser **17**.
> - _(Cálculo: 5 + 10 + 2)_

---

## **⚔️ Mecánicas de Batalla**

Cuando un Wollomon ejecuta un ataque contra un enemigo, ocurren dos cosas:

1.  El enemigo recibe el ataque.
2.  El atacante sufre efectos post-combate.

### **💔 1. Efectos al Recibir un Ataque**

Cuando un Wollomon recibe un ataque, sus `puntos de salud` disminuyen en una cantidad igual al daño que efectúa el atacante.

> **Ejemplo:** Si un Bicho con 3 ataques (daño 10, 15 y 20) ataca a un Dragón, el Dragón perderá 45 PS (ya que el daño del Bicho es 10 + 15 + 20).

### **⚡ Caso particular: Wollomon tipo Eléctrico**

- Además de perder PS, cuando un Eléctrico recibe un ataque, su `nivel` **disminuye en 1 punto**.

### **📈 2. Efectos Post-Combate (Sobre el Atacante)**

Varían según el tipo del Wollomon **atacante**:

- **🐛 Bicho**: Su `nivel` aumenta en **10 puntos**.
- **🐉 Dragón**: Su `nivel` aumenta la **mitad del valor** de su `fuego interior`.
- **⚡ Eléctrico**:
  - Si está `cargado`: Su `nivel` aumenta en **20 puntos**.
  - Si no está `cargado`: No aumenta de nivel.
- **✨ Legendario**: Aplican los **mismos efectos que un Dragón**.

### **📋 Requerimiento (Batalla)**

- Un Wollomon debe poder **atacar a otro Wollomon** si cumple las condiciones necesarias. Al atacar, debe aplicar el daño al enemigo y los efectos post-combate sobre sí mismo.

---

## **🏁 Checkpoint 2**

#### ✅ Segundo _commit_ al repositorio.

### **🧪 Mecánicas de Batalla (Eléctrico vs. Eléctrico)**

**Objetivo:** Validar una batalla completa: el daño del atacante, el efecto en el receptor (incluyendo el caso particular del Eléctrico) y el efecto post-combate en el atacante.

> **📌 Dado:**
>
> - Atacante: **`Picachito`** (Eléctrico)
>   - `nivel: 10`
>   - `ataques: [Ataque(daño: 30), Ataque(daño: 15)]` (usará el primero)
> - Enemigo: **`Raichu`** (Eléctrico)
>   - `nivel: 12`
>   - `PS: 200` (el que tienen por default)
> - Condición climática: **Humedad = 98** (`Picachito` está `cargado`).
>
> **⚙️ Cuando:**
>
> - `Picachito` ataca a `Raichu`.
>
> **✅ Entonces (Resultados):**
>
> - **`Raichu` (Receptor):**
>   - Recibe 30 de daño (el primer ataque de `Picachito`).
>   - Sufre el efecto "Caso particular Eléctrico": su nivel disminuye en 1.
>   - **Verificar** que sus `PS` quedan en **170**.
>   - **Verificar** que su `nivel` queda en **11**.
> - **`Picachito` (Atacante):**
>   - Su nivel aumenta en 20 (efecto post-combate por estar `cargado`).
>   - **Verificar** que su `nivel` queda en **30**.

---

### **🧪 Mecánicas de Batalla (Dragón vs. Bicho)**

**Objetivo:** Validar una batalla completa: el daño del atacante (Dragón), el efecto en el receptor (Bicho, sin caso particular) y el efecto post-combate (Dragón).

> **📌 Dado:**
>
> - Atacante: **`Dragonait`** (Dragón)
>   - `nivel: 20`
>   - `fuegoInterior: 30` (Puede atacar)
>   - `ataques: [Ataque(daño: 10), Ataque(daño: 25)]` (Mejor ataque es 25)
> - Enemigo: **`Mantecafly`** (Bicho)
>   - `nivel: 5`
>   - `PS: 100`
> - Condición climática: (Irrelevante para este test).
>
> **⚙️ Cuando:**
>
> - `Dragonait` ataca a `Mantecafly`.
>
> **✅ Entonces (Resultados):**
>
> - **`Mantecafly` (Receptor):**
>   - Recibe 55 de daño (30 fuego + 25 mejor ataque).
>   - No sufre ningún "caso particular".
>   - **Verificar** que sus `PS` quedan en **45**.
>   - **Verificar** que su `nivel` se mantiene en **5**.
> - **`Dragonait` (Atacante):**
>   - Su nivel aumenta la mitad de su fuego interior (30 / 2 = 15).
>   - **Verificar** que su `nivel` queda en **35**.

---

## **🏆 Torneos**

Los torneos agrupan varios Wollomon participantes y permiten organizar batallas entre ellos.

### **⚙️ Funcionalidades de los Torneos**

- **Aprender ataque masivo**: Todos los participantes del torneo aprenden un nuevo ataque específico.
- **Batallar entre dos Wollomon específicos**: Se realiza una batalla donde un Wollomon ejecuta un ataque contra otro. **(Si alguno de los dos no está participando del torneo deberá fallar).**
- **Batallar automáticamente**: El participante con **mayor nivel** batalla contra el participante con **mayor cantidad de PS**.
- **Dar poción**: Se da una poción (aumenta **20 PS**) a todos los Wollomon que tienen **menos de 50 PS**.

### **📋 Requerimientos (Torneo)**

Se debe poder:

- Hacer que todos los participantes de un torneo aprendan un ataque.
- Hacer que un Wollomon específico ataque a otro específico dentro del torneo.
- Hacer que automáticamente el de mayor nivel ataque al de mayor PS.
- Poder dar poción a los Wollomon que la necesitan (menos de 50 PS).

---

## **🏁 Checkpoint 3**

#### ✅ Tercer _commit_ al repositorio.

### **🧪 Lógica de Torneo (Validación de Participantes)**

**🎯 Objetivo:** Validar que el torneo no permita batallas si uno de los Wollomon no está inscrito, cumpliendo el requerimiento `(Si alguno de los dos no está participando del torneo deberá fallar)`.

> **📌 Dado:**
>
> - Un `Torneo` llamado "CopadeFuego".
> - Participante 1: **`Picachito`** (inscrito en el torneo).
> - Participante 2: **`Wulbasaur`** (inscrito en el torneo).
> - No Participante: **`Escuartol`** (NO está inscrito en el torneo).
>
> **⚙️ Cuando:**
>
> - Se intenta batallar `Escuartol` vs `Picachito` .
>
> **✅ Entonces (Resultado):**
>
> - Verificar que la operación **falla**, lanzando un error con un mensaje similar a: **"Uno de los Wollomon no está participando del torneo"**.

---

### **🧪 Lógica de Torneo (Dar Poción)**

**🎯 Objetivo:** Validar que la función "Dar Poción" del torneo solo afecta a los Wollomon con menos de 50 PS, y no a los demás.

> **📌 Dado:**
>
> - Un `Torneo` llamado "CopaMaravilla".
> - Participante 1: **`Picachito`** (inscrito) \* `PS: 40` (Debe recibir poción)
> - Participante 2: **`Wulbasaur`** (inscrito) \* `PS: 70` (No debe recibir poción)
> - Participante 3: **`Charmanda`** (inscrito) \* `PS: 49` (Debe recibir poción)
>
> **⚙️ Cuando:**
>
> - Se ejecuta la función de dar poción del torneo.
>
> **✅ Entonces (Resultado):**
>
> - **Verificar** que los `PS` de `Picachito` quedan en **60** (40 + 20).
> - **Verificar** que los `PS` de `Wulbasaur` se mantienen en **70**.
> - **Verificar** que los `PS` de `Charmanda` quedan en **69** (49 + 20).

---
