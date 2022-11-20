# Ladder diagramme
type
  VariableKind = enum
    vkBool,
    vkInt,
    vkFloat,
    vkString
  Variable = ref object of RootObj
    case kind: VariableKind
    of vkBool:   boolVal:bool
    of vkInt:    intVal:int
    of vkFloat:  floatVal:float
    of vkString: stringVal:string

  Var = ref object of RootObj
  RelayState = ref object of Var
    val:bool
  Model = ref object of RootObj
    inputs:seq[Var]
    outputs:seq[Var]
    relationships:seq[proc(args:varargs[Variable]):Variable]



# States
type
  Relay = enum
    Connected
    Unconnected

# Events are procedures
proc switch(this:var Relay ) =
  if this == Connected:
    this = Unconnected
  this =  Connected

proc `and`(a,b:Relay):Relay =
  if a == Connected and b == Connected:
    return Connected
  else:
    return Unconnected


proc main =
  var rele1:RelayState 
  rele1.val = false    #Variable(kind: vkBool, boolVal: false)  
  var rele2:RelayState 
  rele2.val = false    #Variable(kind: vkBool, boolVal: false)  
  var rele3:RelayState
  var m:Model
  m.inputs = @[rele1, rele2]
  m.outputs = @[rele3]

proc main2 =
  var rele1: Relay = Unconnected  # Default state (or entry action)
  var rele2: Relay = Connected  # Default state (or entry action)

  var rele3: Relay = rele1 and rele2    
  echo rele1, rele2, rele3
  rele1.switch
  echo rele1, rele2, rele3

main()