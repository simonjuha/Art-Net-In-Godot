extends Node
class_name DMXFunction
## Base class for DMX functions
## This class should be extended to create custom DMX functions

var channel_size: int = 1
var channel_index: int = 0

func _ready():
    pass

func process_dmx(dmx: Array):
    push_error("The 'process_dmx' must be overridden in the derived class!") # Replace with function body.
    pass