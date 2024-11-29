extends Node3D
class_name DmxFixture

@export var dmx_channel_offset: int = 0		# DMX channel offset

var local_dmx_data: Array 					# local data kept in lamp
var total_channels: int = 0					# total number of channels - increases with each added channel

func set_fixture_channels(channel_count: int) -> void:
	total_channels = channel_count + 1
	add_to_group("dmx_fixtures")
	pass

func add_to_dmx_universe(artnet: ArtNet):
	artnet.connect("dmx_updated", Callable(self, "_check_dmx"))
	pass

func _check_dmx(dmx_data_array: Array) -> void:
# se if local data is different from the new data
	var temp_local_dmx_data = dmx_data_array.slice(dmx_channel_offset, total_channels + dmx_channel_offset)
	if temp_local_dmx_data != local_dmx_data:
		local_dmx_data = temp_local_dmx_data
		# process the data
		process_dmx(local_dmx_data)

# This function should be overridden in the derived class, processing dmx property names and values
func process_dmx(dmx: Array):
	push_error("The 'process_dmx' must be overridden in the derived class!") # Replace with function body.
pass
