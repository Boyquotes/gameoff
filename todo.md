HIGH
- **level design**

MID
- draw own sprites. possible inspiration: brotato, broforce, serious sam bogus detour. size 64x64
- if in flow state of fun, items recharge faster. how does it work with counters? maybe should think of flow as difficulty. increases when shot at, player level increases when killing enemies, and will need more enemies to be entertained. ie. lvl1 = 2 enemies, lvl2 = 4 enemies etc
- add dialog messages
- audio
- game over condition
- menu
- more items:
  - melee enemies
  - kamikaze enemies
  - gun turrets
  - rpg/grenades
  - shotgun weapon/ different weapons
  - cover based shooting
- remove or merge one of the other resources
- bug: characters moving through walls at times. maybe solved by removing collision avoidance
- UI for powerups

LOW
- juice (when placing items, when player does stuff)
  - projectiles with trails
  - hit/death animations
- destructible terrain
- ai tweaks:
  - move to ending if no ammo and no ammo in sight
  - only move to distant items if in critical condition
  - enemies should be rigidbodies so that they can be moved a bit
  - fire priority: should shoot barrels first
- try mobile version
- powerup: 2x speed
- moving around corners
- fire animations

after jam
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