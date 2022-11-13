HIGH
- **design economy for powerups (gain resources while in flow state, use it to spend on items)**
- **level design**

MID
- juice (when placing items, when player does stuff)
  - projectiles with trails
  - hit/death animations
- use vision collision to avoid placing items
- draw own sprites. possible inspiration: brotato, broforce, serious sam bogus detour
- UI for powerups
- audio
- game over condition
- menu
- bug: characters moving through walls at times

LOW
- only move to distant items if in critical condition
- enemies should be rigidbodies so that they can be moved a bit
- fire priority: should shoot barrels first
- fire animations
- shots randomness
- try mobile version
- different types of weapons
- moving around corners
- export vision cone as asset

probably cut
- setup github CI to upload to itch
- reimplement behaviour trees? (for fun mostly)

improvements to beehave:
- node descriptions
- add random selector composite node 
- dive deeper into explanation https://www.gamedeveloper.com/programming/behavior-trees-for-ai-how-they-work
- compare with UE implementation: https://docs.unrealengine.com/4.27/en-US/InteractiveExperiences/ArtificialIntelligence/BehaviorTrees/BehaviorTreesOverview/
  - conditionals as decorators instead of leaf nodes as it improves readability
- https://github.com/libgdx/gdx-ai/wiki/Behavior-Trees