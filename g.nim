# Ejemplo de Ladder
import std/[sugar, strformat]

# Define the states
type
  RelayState = enum
    Connected
    Unconnected
type
  Relay = ref object
    name:string
    state:RelayState

# Define the events as procedures
proc switch(this:var Relay ) =
  if this.state == Connected:
    this.state = Unconnected
  else:
    this.state = Connected


# Lo siguiente sería de los concepts
# Esto sería lo típico de un concept
proc `and`(a,b:Relay):RelayState =
  if a.state == Connected and b.state == Connected:
    return Connected
  else:
    return Unconnected

proc `or`(a,b:Relay):RelayState =
  if a.state == Connected or b.state == Connected:
    return Connected
  else:
    return Unconnected


type
  ModelState = object
    name:string
    states:seq[Relay]

proc update(this:var ModelState) =
  # impose the relationships between states
  this.states[2].state = this.states[0] and this.states[1]


# This is the model definition

proc `$`(this:var ModelState):string =
  this.update
  var tmp = this.name & ":\n"
  for st in this.states:
    tmp &= &"  {st.name}={st.state}\n"
  #return &"{this.name}:\n  rele1={this.states[0]}\n  rele2={this.states[1]}\n  rele3={this.states[2]}"
  return tmp

proc defineModel(): ModelState =
  result.name = "prueba"
  # Set defaults (for each substate)
  result.states &= @[ Relay(name:"33WF", state:Unconnected),
                      Relay(name:"44WF", state:Connected),
                      Relay(name:"15xs", state:Unconnected) ]
   
  
#------------------------
proc main =
  var m = defineModel()
  
  echo m
  for i in 1..3:
    m.states[0].switch
    echo m

main()