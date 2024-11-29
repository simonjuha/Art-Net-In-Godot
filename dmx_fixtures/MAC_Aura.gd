# MAC Aura
extends DmxFixture
var light_source: Light3D
enum MacAura {
	BEAM_SHUTTER_EFFECT = 0,
	BEAM_DIMMER = 1,
	ZOOM = 2,
	PAN = 3,
	PAN_FINE = 4,
	TILT = 5,
	TILT_FINE = 6,
	FIXTURE_CONTROL_SETTINGS = 7,
	BEAM_COLOR_EFF = 8,
	BEAM_RED = 9,
	BEAM_GREEN = 10,
	BEAM_BLUE = 11,
	BEAM_WHITE = 12,
	CTC = 13,
	FX1_SELECT = 14,
	FX1_SPEED = 15,
	FX2_SELECT = 16,
	FX2_SPEED = 17,
	SYNC = 18,
	AURA_SHUTTER = 19,
	AURA_DIMMER = 20,
	AURA_COLOR_WHEEL_EFF = 21,
	AURA_RED = 22,
	AURA_GREEN = 23,
	AURA_BLUE = 24
}

func _ready():
	light_source = $Light3D
	set_fixture_channels(0, MacAura.size())


func process_dmx(dmx: Array):
	light_source.light_color.r = dmx[MacAura.BEAM_RED] / 255.0
	light_source.light_color.g = dmx[MacAura.BEAM_GREEN] / 255.0
	light_source.light_color.b = dmx[MacAura.BEAM_BLUE] / 255.0
	light_source.light_energy = dmx[MacAura.BEAM_DIMMER] / 64.0
	light_source.spot_angle = dmx[MacAura.ZOOM] / 255.0 * 90.0
	light_source.rotation_degrees.y = dmx[MacAura.PAN] / 255.0 * 360.0
	light_source.rotation_degrees.x = dmx[MacAura.TILT] / 255.0 * 180.0


	pass





		
