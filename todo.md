HIGH
- player can select from multiple objects to place
- collision mesh on vision cone

MID
- sprite render on vision cone
- character health visible
- player fun
- bug: enemies shuffle move while firing
- fire animations (missing muzzle flash)

LOW
- fire priority: should shoot barrels first
- export vision cone as asset
- shots randomness and direct vision
- different types of weapons
- moving around corners
- game over condition
- menu
- audio
- reimplement behaviour trees? (for fun mostly)

improvements to beehave:
- node descriptions
- add random selector composite node 
- dive deeper into explanation https://www.gamedeveloper.com/programming/behavior-trees-for-ai-how-they-work
- compare with UE implementation: https://docs.unrealengine.com/4.27/en-US/InteractiveExperiences/ArtificialIntelligence/BehaviorTrees/BehaviorTreesOverview/
  - conditionals as decorators instead of leaf nodes as it improves readability
- https://github.com/libgdx/gdx-ai/wiki/Behavior-Trees