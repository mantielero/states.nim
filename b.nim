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
  var rele1: Relay = Unconnected  # Default state (or entry action)
  var rele2: Relay = Connected  # Default state (or entry action)

  var rele3: Relay = rele1 and rele2    
  echo rele1, rele2, rele3
  rele1.switch
  rele3 = rele1 and rele2  # Requires reevaluation after switching
  echo rele1, rele2, rele3

main()