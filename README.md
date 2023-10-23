# BUK Tech Adventure

Base game for the Tech activity at BUK Høstcamp 2023

## Features

- [x] Tilemap to easily build a world
- [x] Player character
  - [x] Player character can only walk on marked parts of the tiles
- [x] NPC
- [ ] Dialogue mechanism for quests
- [ ] Inventory mechanism


## Building a world

We've got an isometric tileset to build the world. This means that you can relatively easily "paint" a world.

You can study the _test_ and _cave_ scenes to see how this is done:

1. Open the _test.tscn_ scene
2. It's easiest to work with your own copy. Use _Scene_ » _Save Scene As…_ to save a copy of the scene.
3. Ensure you have _2D_ selected at the top of the screen.
4. Click the root node called _world_
5. In the bottom centre of the screen, select the _TileMap_ tab.
6. You'll see the base layer of the tile map highlighted, with higher layers transparently overlaid.
7. In the top-right part of the _TileMap_ tab, you can select a different layer.
8. Pay attention how the map is built of layers.
   - The buildings, fence, trees are higher layers on top of the base layer. If you paint such things on the same layer as the ground, they would _replace_ the ground tiles and leave holes in the world.
   - The cliff part is a higher layer without a base layer below it except for below the cliff edge.
9. The tiles already have a lot of technical information correctly set, such that your player can only walk where it makes sense.

There are three different ways to draw on the map, two of which we'll use. These three are accessible through the tabs on the top-left of the _TileMap_ tab.

- Tiles: This is the simplest. Select a block from the tile map and draw in on the map.
- Patterns: Here you can save completed pieces of a map, such as a building, and draw a lot of copies of it. We haven't prepared any patterns.
- Terrains: This is the most complicated method, but sometimes it works really nicely. I recommend this method to draw things like roads, water, and trees, and maybe castle walls. This method will automatically try to insert the correct tile from a selection based on the surrounding tiles. In some cases however, there are many different tiles that are technically equally likely, and the system uses ones that are obviously wrong from a human perspective.
  
In the _Tiles_ and _Patterns_ tabs there are five different tools available for drawing:

- Cursor: You don't actually draw, but you can click to select a tile, click-drag to select multiple tiles, and click-drag selected tile(s) to move them.
- Pencil: Draw completely free form while holding down the mouse. Great for the details
- Line: Draw a straight line while holding down the mouse. The tiles will be placed when you release the mouse. Great for drawing straight cliff faces.
- Rectangle: Click and drag to draw a rectangular area. Great if you want to quickly create the base layer of your level.
- Bucket: Fill the current contiguous area. Great if you want to make a base layer that's non-rectangular. Just use lines to draw the edges, then use the bucket to fill the centre.
  
Aside from that, once you've selected a tool, you have three more options:

- Eyedropper: Click this, then click a place in the current layer, to select that tile as your current brush
- Eraser: Toggle erase mode. However, painting with the right mouse-button will also erase, and that is generally quicker.

Then there's a last option: Click the die to enable randomness. Set _scattering_ to a high enough value, and you painting will become erratic. This is useful if you want to paint e.g. scattered rocks on a landscape.  

Once you're done learning the tools
If you want to build you own world, you can do it like this:

1. Erase all _child_ nodes from your copy of the scene.
2. Click the _world_ node to edit the map, and use the rectangle tool to quickly erase all layers.
3. Make sure you're in layer 1.
4. Choose a base tile for your new world. The recommended tiles are _grass_ or _sand_ and to a lesser extent _dirt_ and _water_.
5. Paint a large area as your main land(or water)mass.
6. Add buildings keep in mind that each floor of the building must be one layer higher than that of the previous floor/ground.
7. Use _Terrain_ mode to paint roads, rivers and water.
8. Add trees, fences, farms etc.
10. Paint elevated areas if you like.

### Elevated area

Elevated areas are limited in functionality right now, it's not recommended that you draw an elevated area that's meant to be reachable by the player.
In the _test_ scene there's an elevated area, but it's not player reachable. It's just there so that the player can enter the _cave_ scene.

The cliffs facing away from the camera do not have collision. The player can walk straight through them. If you open the _cave_ scene and edit the map and look at layer 2, you can see that there's actually a fence hidden behind the cliff that prevents the player from walking through the cliff. This is because it was not possible to create a cliff tile that works correctly, both to walk on top of, and to walk behind, at the same time. This way you get both, with some extra work. If you want to walk on top of the cliff edge, place it on layer 1, and it works. If you want to walk behind it, place it on layer 3 and hide a fence behind it on layer 2.

## Map entrances and exits

Once you've created your map, you may want to test it out:

1. Add an _entrance_ scene to your map, by dragging it into the map from the filesystem in the bottom left part of the UI.
    Note: The entrance scene doesn't have any visuals, you'll just see a small crosshair indicator that shows that it's there.
2. Select the entrance node and in the _Inspector_ check the option _Map Start Point_. Each map should have only _one_ entrance that has this option checked.
3. Click _Run current scene_ near the top-right corner of the screen, or press <kbd>F6</kbd> to start the _current_ scene.
    If you click the play icon _Run project_ (<kbd>F5</kbd>) instead, you'll end up in the _default_ scene which it _test_.
4. The game should start in your scene, with the player at the _entrance_.

### Exits

1. Add an _entrance_ scene to your map, by dragging just as you did with the entrance. The exit node does have a visual indicator.
2. Select the exit node and in the _Inspector_ select the _To Scene_. That is the scene you will go to when you enter this exit.
3. Also enter the _Entrance Name_ which is the name of the _entrance_ node in the target scene where the player should appear.

You can study the _test_ and _cave_ scenes to see how this works. The _test_ scene has an _exit_ named *to_cave*. It has _To Scene_ set to the _cave_ scene and it has _Entrance Name_ set to _entrance_, which refers to the _entrance_ node in the _cave_ scene. **NOT** the _entrance_ node in the _test_ scene.

The _cave_ scene has an _entrance_ and _exit_ too. The _entrance_ has _Map Start Point_ set. This means that if you directly start the _cave_ scene, the player will spawn there. It is also the place where the player will spawn when you enter from the _test_ map through the *to_cave* exit, because that exit refers to this entrance by its name _entrance_.

The _exit_ has _To Scene_ set to the _test_ scene and has _Entrance Name_ set to *from_cave*. This ensures that when you exit the cave, the player will appear at the entrance called *from_cave* in the test scene. If no _Entrance Name_ was set, you would end up at the map start point instead.
