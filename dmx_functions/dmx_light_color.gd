extends DMXLightFunction
class_name DMXLightRGBColor

func _ready() -> void:
	channel_size = 3

func process_dmx(dmx: Array):
	var red = dmx[channel_index]
	var green = dmx[channel_index + 1]
	var blue = dmx[channel_index + 2]
	light_source.light_color = Color(red / 255.0, green / 255.0, blue / 255.0)
	pass
