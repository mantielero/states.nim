# Ejemplo de Ladder
import sugar
import std/strformat


# Define the states
type
  Relay = enum
    Connected
    Unconnected

# Define the events as procedures
proc switch(this:var Relay ) =
  if this == Connected:
    this = Unconnected
  else:
    this =  Connected



type
  ModelState = object
    name:string
    rele1, rele2, rele3: Relay
    relationships:seq[ proc(this:var ModelState) ] 




# Esto sería lo típico de un concept
proc `and`(a,b:Relay):Relay =
  if a == Connected and b == Connected:
    return Connected
  else:
    return Unconnected

# The whole model would be a function
proc process(this:var ModelState ) =
  this.rele3 = this.rele1 and this.rele2

proc update(this:var ModelState) =
  for f in this.relationships:
    this.f

proc `$`(this:var ModelState):string =
  this.update
  return fmt"{this.name}: rele1:{this.rele1} rele2:{this.rele2} rele3: {this.rele3}"

proc main =
  var m:ModelState
  m.name = "prueba"
  m.rele1 = Unconnected
  m.rele2 = Connected
  m.relationships &= process
  echo m

  for i in 1..3:
    m.rele1.switch
    echo m

main()