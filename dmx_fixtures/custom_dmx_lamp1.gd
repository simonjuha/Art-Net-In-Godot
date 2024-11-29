extends DmxFixture

var light_source: Light3D

func _ready():
    light_source = $Light3D
    # adding channels
    add_channel("dimmer")
    add_channel("red")
    add_channel("green")
    add_channel("blue")

func process_light(channel_name: String, channel_value: int):
    match channel_name:
        "dimmer":
            light_source.light_energy = channel_value / 255.0 * 5.0
        "red":
            light_source.light_color.r = channel_value / 255.0
        "green":
            light_source.light_color.g = channel_value / 255.0
        "blue":
            light_source.light_color.b = channel_value / 255.0
        _:
            print("Unknown channel name: ", channel_name)
