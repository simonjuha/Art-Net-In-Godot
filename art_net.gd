@icon("res://editor/icons/artnet.svg")
extends Node
class_name ArtNet
## Art-Net Node
## This node is responsible for receiving Art-Net packages and updating the DMX data array
## DMX data is passed to the fixtures that are added to the "dmx_fixtures" group
## This node should be added to the root of the scene (bottom of the scene tree) to ensure that all fixtures are added to the universe

var udp_socket: PacketPeerUDP
@export var listening_port: int = 6454:
	set(value):
		if udp_socket:
			push_error("Cannot change listening port after the socket has been initialized")
		else:
			listening_port = value
@export var DMX_universe: int = 0
var dmx_data: Array = Array()  # Initialize an empty array

var dmx_frame = null

signal dmx_updated

func _ready():
	for i in range(512):
		dmx_data.append(0)  # Set all 512 values to 0
	# Initialize UDP Socket
	udp_socket = PacketPeerUDP.new()
	var result = udp_socket.bind(listening_port)
	if result != OK:
		push_error("Failed to open UDP socket on port %d" % listening_port)
	else:
		var ip_address
		for a in IP.get_local_addresses():
			if (a.split('.').size() == 4):
				ip_address = a
		print("Listening on: ", ip_address, ":", udp_socket.get_local_port())
	
	#check if group is empty
	if get_tree().has_group("dmx_fixtures") == false:
		push_error("No fixtures found in the scene")
		return

	# add fixtures to the universe
	for fixture in get_tree().get_nodes_in_group("dmx_fixtures"):
		fixture.add_to_dmx_universe(self)
		print("Added ", fixture.name, " to universe")

func _process(_delta):
	if udp_socket.get_available_packet_count() > 0:
		var packet = udp_socket.get_packet()
		update_dmx_data(packet)

func update_dmx_data(package: PackedByteArray):
	# check if Art-Net package
	if package.slice(0, 8).get_string_from_ascii() != "Art-Net":
		return

	# check if Art-Net DMX Channels 0x500
	var opcode = package.decode_u16(8)
	if opcode != 0x5000:
		return
		
	# Check for universe
	var universe = package.decode_u16(14)
	if universe != DMX_universe:
		return

	# check frame/sequence
	var new_dmx_frame = package[12]
	if (dmx_frame == null) or (new_dmx_frame > dmx_frame) or (dmx_frame > new_dmx_frame and new_dmx_frame < 128):
		dmx_frame = new_dmx_frame
	else:
		return
	
	for i in range(512):
		dmx_data[i] = package[ i + 18]
	emit_signal("dmx_updated", dmx_data)

func get_dmx_data(channel: int) -> int:
	return dmx_data[channel]
