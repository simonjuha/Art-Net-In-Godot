extends DMXFunction
class_name DMXLightFunction
## Base class for DMX light-based functions

var light_source: Light3D

func set_light_source(light: Light3D):
    light_source = light