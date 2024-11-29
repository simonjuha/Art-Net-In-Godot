# Art-Net simulation in Godot
I was wondering if Godot would be a nice tool for simulating DMX lighting, so i made some script for this prupose.
use connect on an _ArtNet_ instance to get updated DMX frames. All _DmxFixture_ in a scene is automaticly added to the _ArtNet_ class through a group called 'dmx_fixtures'
## How to use
TO create a new dmx fixture type, create a script the extends the _DmxFixture_ class. call the method _set_fixture_channels(n_channels)_, where _channels are the number of dmx channels that the faxture takes up. Each node _DmxFixture_ has an export property "DMX channel offset" tha tshould be set to the wanted channel offset. A example of how a light source can be controlled can be found in the "dmx_fixtures" folder.
## Network
Whatever softare you are using this script should work with both broadcast and unicast.
