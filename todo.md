HIGH
- move towards pickups
- collision mesh on vision cone

MID
- sprite render on vision cone
- player fun
- UI for powerups
- economy for powerups (gain resources while in flow state, use it to spend on items)
- bug: enemies shuffle move while firing
- fire animations (missing muzzle flash)
- draw own sprites. possible inspiration: brotato, broforce

LOW
- view player path in with line renderer
- add dynamic object avoidance to characters
- fire priority: should shoot barrels first
- shots randomness and direct vision
- export vision cone as asset
- level design
- game over condition
- audio
- menu
- different types of weapons
- moving around corners
- reimplement behaviour trees? (for fun mostly)

improvements to beehave:
- node descriptions
- add random selector composite node 
- dive deeper into explanation https://www.gamedeveloper.com/programming/behavior-trees-for-ai-how-they-work
- compare with UE implementation: https://docs.unrealengine.com/4.27/en-US/InteractiveExperiences/ArtificialIntelligence/BehaviorTrees/BehaviorTreesOverview/
  - conditionals as decorators instead of leaf nodes as it improves readability
- https://github.com/libgdx/gdx-ai/wiki/Behavior-Trees