extends DMXLightFunction
class_name DMXLightIntensity

func process_dmx(dmx: Array):
	light_source.light_energy = dmx[channel_index] / 255.0
	pass
