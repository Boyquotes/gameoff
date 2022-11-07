HIGH
- bug: barrel can't be killed
- collision mesh on vision cone

MID
- items shouldn't inherit from Character
- player fun
- UI for powerups
- economy for powerups (gain resources while in flow state, use it to spend on items)
- sprite render on vision cone
- bug: enemies shuffle move while firing
- draw own sprites. possible inspiration: brotato, broforce
- fire animations (missing muzzle flash)

LOW
- view player path with line renderer
- add dynamic object avoidance to characters
- fire priority: should shoot barrels first
- shots randomness and hitscan vision
- level design
- game over condition
- audio
- menu
- export vision cone as asset
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