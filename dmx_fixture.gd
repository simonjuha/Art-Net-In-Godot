extends Node
class_name DMXFixture
## A DMX fixture that contains multiple DMX functions (DMXLightFunction)
## DMXLightFunction nodes added as children will be processed by the fixture

@export var dmx_channel_offset: int = 0
var channels: Array[DMXFunction] = []
func _ready():
	add_to_group("dmx_fixtures")
	var light_source: Light3D = null
	for child in get_children():
		if child is Light3D:
			light_source = child
			break
	
	for child in get_children():
		if child is DMXLightFunction:
			child.set_light_source(light_source)
		if child is DMXFunction:
			child.channel_index = channels.size() + dmx_channel_offset
			for j in range(child.channel_size):
				channels.append(child)

func process_dmx(dmx_data_array: Array) -> void:
	for i in range(channels.size()):
		channels[i].process_dmx(dmx_data_array)
	pass

func add_to_dmx_universe(artnet: ArtNet):
	print("Adding to DMX universe")
	artnet.connect("dmx_updated", Callable(self, "process_dmx"))
	pass
