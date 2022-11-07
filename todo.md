HIGH
- health packs
- ammo for player
- ammo pickup
- collision mesh on vision cone

MID
- sprite render on vision cone
- character health visible
- player fun
- UI for player selections
- bug: enemies shuffle move while firing
- fire animations (missing muzzle flash)

LOW
- view player path in with line renderer
- fire priority: should shoot barrels first
- shots randomness and direct vision
- export vision cone as asset
- level design
- game over condition
- audio
- menu
- different types of weapons
- moving around corners
- draw own sprites. possible inspiration: brotato, broforce
- reimplement behaviour trees? (for fun mostly)

improvements to beehave:
- node descriptions
- add random selector composite node 
- dive deeper into explanation https://www.gamedeveloper.com/programming/behavior-trees-for-ai-how-they-work
- compare with UE implementation: https://docs.unrealengine.com/4.27/en-US/InteractiveExperiences/ArtificialIntelligence/BehaviorTrees/BehaviorTreesOverview/
  - conditionals as decorators instead of leaf nodes as it improves readability
- https://github.com/libgdx/gdx-ai/wiki/Behavior-Trees