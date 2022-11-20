import synthesis


# States and events
type Contact = enum
  ## States of your automaton.
  ## The terminal state does not need to be defined
  Connected
  Unconnected
  

type Event = enum
  ## Named events. They will be associated with a boolean expression.
  Switch
  OutOfCommands

declareAutomaton(contact, Contact, Event)

setPrologue(contact):
  echo "Welcome to the Steamy machine version 2000!\n"
  var button: bool

# Mandatory initial state. This must be one of the valid state of the "Phase" enum.
setInitialState(contact, Unconnected)

# Terminal state is mandatory. It's a pseudo state and does not have to be part of the state enum.
setTerminalState(contact, Exit)

# Optionally setup the "epilogue". Cleaning up what was setup in the prologue goes there.
setEpilogue(contact):
  echo "Now I need some coffee."

# Lo siguiente indica qué condiciones disparan un evento.
implEvent(contact, Switch):
  button

implEvent(contact, OutOfCommands):
  buttonStatus.len == 0

onEntry(contact, [Connected, Unconnected]):
  #let oldTemp = temp
  button = buttonStatus.pop()
  echo "Button pressed: ", button




behavior(contact):
  ini: Connected
  fin: Unconnected
  event: Switch
  transition:
    assert button
    echo "unconnecting\n"

behavior(contact):
  ini: Unconnected
  fin: Connected
  event: Switch
  transition:
    assert button
    echo "connecting\n"

behavior(contact):
  ini: [Connected, Unconnected]
  fin: Exit
  interrupt: OutOfCommands
  transition:
    echo "no more commands left\n"

behavior(contact):
  steady: [Unconnected, Connected]
  transition:
    echo "doing nothing\n"

behavior(contact):
  ini: [Unconnected, Connected]
  fin: Exit
  interrupt: OutOfCommands
  transition:
    echo "No more presses left ..."


synthesize(contact):
  proc contact(buttonStatus: var seq[bool])

#----------
proc main() =
    var b1 = @[false,false, true, false, true]
    echo b1
    contact(b1)

main()