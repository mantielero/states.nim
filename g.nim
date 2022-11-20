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
    this = Connected


# Lo siguiente sería de los concepts
# Esto sería lo típico de un concept
proc `and`(a,b:Relay):Relay =
  if a == Connected and b == Connected:
    return Connected
  else:
    return Unconnected

proc `or`(a,b:Relay):Relay =
  if a == Connected or b == Connected:
    return Connected
  else:
    return Unconnected


type
  ModelState = object
    name:string
    states:seq[Relay]

proc update(this:var ModelState) =
  # impose the relationships between states
  this.states[2] = this.states[0] and this.states[1]


# This is the model definition

proc `$`(this:var ModelState):string =
  this.update
  return &"{this.name}:\n  rele1={this.states[0]}\n  rele2={this.states[1]}\n  rele3={this.states[2]}"

proc defineModel(): ModelState =
  result.name = "prueba"
  # Set defaults (for each substate)
  result.states &= @[ Unconnected,
                      Connected,
                      Unconnected ]
   
  
#------------------------
proc main =
  var m = defineModel()
  
  echo m
  for i in 1..3:
    m.states[0].switch
    echo m

main()