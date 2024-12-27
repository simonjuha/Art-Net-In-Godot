extends DMXLightFunction
class_name DMXLightIntensity
## A simple light function that sets the intensity of a light source based on the DMX data

func process_dmx(dmx: Array):
	light_source.light_energy = dmx[channel_index] / 255.0
	pass
