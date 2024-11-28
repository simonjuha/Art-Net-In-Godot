extends Node

var udp_socket: PacketPeerUDP
@export var listening_port: int = 6454
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
		udp_socket.set_broadcast_enabled(true)
		var result2 = udp_socket.set_dest_address("255.255.255.255", 6454)
		if result2 != OK:
			push_error("Failed to set destination address")

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
		
	# ToDo: Check for universe

	# check frame/sequence
	var new_dmx_frame = package[12]
	if (dmx_frame == null) or (new_dmx_frame > dmx_frame) or (dmx_frame > new_dmx_frame and new_dmx_frame < 128):
		dmx_frame = new_dmx_frame
	else:
		return
	print("frame: " + str(dmx_frame))
	
	for i in range(512):
		dmx_data[i] = package[ i + 18]
	emit_signal("dmx_updated", dmx_data)

func get_dmx_data(channel: int) -> int:
	return dmx_data[channel]
