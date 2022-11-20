# Ejemplo de Ladder
import std/[sugar, strformat]


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


# Lo siguiente sería de los concepts
# Esto sería lo típico de un concept
proc `and`(a,b:Relay):Relay =
  if a == Connected and b == Connected:
    return Connected
  else:
    return Unconnected


# This is the model definition
type
  ModelState = object
    name:string
    rele1, rele2, rele3: Relay   # Todo esto representa el estado del modelo
    outputs:seq[ proc(this:var ModelState) ] 

# The whole model would be a function
proc update(this:var ModelState) =
  for f in this.outputs:
    this.f

proc `$`(this:var ModelState):string =
  this.update
  return &"{this.name}:\n  rele1:{this.rele1} rele2:{this.rele2} rele3: {this.rele3}"

proc defineModel():ModelState =
  result.name = "prueba"
  result.rele1 = Unconnected
  result.rele2 = Connected
   
  result.outputs &= 
    proc(this:var ModelState) = 
      this.rele3 = this.rele1 and this.rele2
  
#------------------------
proc main =
  var m = defineModel()
  
  echo m
  for i in 1..3:
    m.rele1.switch
    echo m

main()