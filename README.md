# 3D Game using Godot Engine

# Prototype Development Roadmap: Samurai Action RPG

## Phase 1: Core Player Mechanics
1. Basic Character Setup
   - [V] Third-person character controller
   - [ ] Basic movement (walk, run, jump, and dodge)
     - [V] Walk
     - [V] Running
     - [P] Jump
     - [ ] Dodge
	 - [ ] Dodge then Run
   - [ ] Camera system with lock-on functionality
   - [ ] Character state machine for different actions

2. Combat Foundation
   - [ ] Basic attack system
   - [ ] Blocking mechanism
   - [ ] Deflection/Parry system (Sekiro-style)
   - [ ] Posture system for both player and enemies
     - [ ] Posture meter UI
     - [ ] Posture break states
     - [ ] Recovery mechanics

3. Animation Integration
   - [ ] Idle, walk, run animations
   - [ ] Basic attack animations
   - [ ] Block/Deflect animations
   - [ ] Hurt/Death animations
   - [ ] Animation state machine

## Phase 2: Enemy Systems
1. Basic Enemy AI
   - [ ] Enemy state machine
   - [ ] Basic pathfinding
   - [ ] Attack patterns
   - [ ] Enemy posture system

2. Combat Interaction
   - [ ] Hit detection system
   - [ ] Damage calculation
   - [ ] Deflection timing windows
   - [ ] Enemy stagger states

## Phase 3: Time-Based Events (WOTS Style)
1. Time System
   - [ ] In-game time tracking
   - [ ] Day/night cycle (simple version)
   - [ ] Event triggering based on time

2. Basic Event System
   - [ ] Event manager
   - [ ] Simple branching dialogue system
   - [ ] Character presence/absence based on time
   - [ ] Event flags and variables

## Phase 4: Multiple Outcomes System
1. Choice System
   - [ ] Dialogue choice system
   - [ ] Faction reputation tracking
   - [ ] Basic consequence system

2. Scenario Management
   - [ ] Event branching
   - [ ] Simple quest system
   - [ ] Character relationship tracking

## Phase 5: Test Environment
1. Test Area
   - [ ] Small village/area layout
   - [ ] NPC placement points
   - [ ] Combat arena
   - [ ] Event trigger zones

2. Debug Features
   - [ ] Time manipulation controls
   - [ ] Event testing tools
   - [ ] Combat stats display
   - [ ] State viewers

## Technical Considerations
- Use placeholder assets initially
  - Basic humanoid models
  - Simple environment assets
  - Prototype UI elements
- Focus on modularity
  - Separate combat system
  - Independent time system
  - Decoupled event system

## Priority Development Order
1. Player movement and camera
2. Basic combat mechanics
3. Enemy AI and interaction
4. Time system
5. Event system
6. Choice/consequence system

## Prototype Success Criteria
- Smooth, responsive combat
- Functional deflection system
- At least one time-based branching event
- Minimum 2-3 different outcomes for testing
- Basic NPC interaction system

##  Asset used
- https://github.com/lukky-nl/third_person_controller_assets
- https://www.kenney.nl/assets/prototype-textures
- ...

## Reference used
- https://www.youtube.com/watch?v=EP5AYllgHy8
- https://www.youtube.com/watch?v=Tbfc_5syCMk
- ...
