extends Node3D
class_name DmxFixture

@export var dmx_channel_offset: int = 0		# DMX channel offset

var local_dmx_data: Array 					# local data kept in lamp
var dmx_channel_names: Array[String] = []	# names of the channels (dimmer, red, etc.)
var total_channels: int = 0					# total number of channels - increases with each added channel

func process_dmx(dmx_data_array: Array) -> void:
	# se if local data is different from the new data
	if local_dmx_data != dmx_data_array.slice(dmx_channel_offset, total_channels):
		local_dmx_data = dmx_data_array.slice(dmx_channel_offset, total_channels)

		for i in range(min(dmx_data_array.size(), dmx_channel_names.size())):
			var dmx_data = dmx_data_array[i]
			process_light(dmx_channel_names[i], dmx_data)
	pass

func add_channel(channel_name: String) -> void:
	dmx_channel_names.append(channel_name)
	total_channels += 1
	add_to_group("dmx_fixtures") # added here to avoid overring the _ready function, might change
	pass

func add_to_dmx_universe(artnet: ArtNet):
	artnet.connect("dmx_updated", Callable(self, "process_dmx"))
	pass

# This function should be overridden in the derived class, processing dmx property names and values
func process_light(channel_name: String, channel_value: int):
	push_error("The 'required_method' must be overridden in the derived class!") # Replace with function body.
pass
