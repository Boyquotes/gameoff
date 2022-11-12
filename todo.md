HIGH
- refactor: replace relative paths with NodePath

MID
- sprite render on vision cone
- design economy for powerups (gain resources while in flow state, use it to spend on items)
- view player path with line renderer
- add dynamic object avoidance to characters
- draw own sprites. possible inspiration: brotato, broforce
- juice (when placing items, when player does stuff)
- level design
- UI for powerups
- game over condition
- audio
- menu

LOW
- bug: enemies shuffle move while firing
- fire priority: should shoot barrels first
- fire animations (missing muzzle flash)
- shots randomness and hitscan vision
- try mobile version
- different types of weapons
- moving around corners

probably cut
- export vision cone as asset
- setup github CI to upload to itch
- reimplement behaviour trees? (for fun mostly)

improvements to beehave:
- node descriptions
- add random selector composite node 
- dive deeper into explanation https://www.gamedeveloper.com/programming/behavior-trees-for-ai-how-they-work
- compare with UE implementation: https://docs.unrealengine.com/4.27/en-US/InteractiveExperiences/ArtificialIntelligence/BehaviorTrees/BehaviorTreesOverview/
  - conditionals as decorators instead of leaf nodes as it improves readability
- https://github.com/libgdx/gdx-ai/wiki/Behavior-Trees