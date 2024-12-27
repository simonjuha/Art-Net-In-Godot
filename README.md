# Art-Net Simulation in Godot
I wondered whether Godot could be a suitable tool for simulating DMX lighting, so I created a script for this purpose. 

You can connect to an _ArtNet_ instance and use the `_dmx_updated` signal to receive updated DMX frames. All _DMXFixture_ nodes in a scene are automatically added to the _ArtNet_ class through a group called `dmx_fixtures`.

## How to Use

1. **Creating a New DMX Fixture Type**  
   To create a new DMX fixture type, follow these steps:  
   - Create a node that uses the _DMXFixture_ script/class.  
   - Add a light source (_Light3D_) and subclasses of _DMXFunction_.  
   
   The _DMXFunction_ nodes act as channels for the fixture, controlling properties like intensity, RGB, tilt/pan, etc. These channels are added to the control in the order the nodes are placed inside the _DMXFixture_.

2. **Setting DMX Channel Offset**  
   Each _DMXFixture_ node has an exported property called "DMX Channel Offset." This property should be set to the desired channel offset.  

3. **Example Scene**  
   An example of how a light source can be controlled is provided in the "example_scene.tscn"

4. **Adding the ArtNet Node**  
   Ensure that a node using the _ArtNet_ script is present in your scene (preferably at the bottom of your scene tree). This script receives Art-Net packets and emits the `_dmx_updated` signal when DMX data changes.
   
## Network
This script should work with any software supporting Art-Net, whether using broadcast or unicast.
