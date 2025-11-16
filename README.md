# Godot ECS-Lite Auto Battle System

This project demonstrates a lightweight **Entity–Component–System (ECS-Lite)** pattern inside **Godot 4**, built for a **1-on-1 Auto-Battle (ATB)** combat system.  
It keeps Godot’s Node workflow while giving the flexibility of modular components and systems. 

As per the last update, the project is developed using [Godot 4.5.1](https://godotengine.org/download/archive/4.5.1-stable/). Other versions may require adjustments.

---

## ✨ Features

### 🔹 ECS-Lite Architecture
A simplified ECS structure:
- **Entity** → Nodes (`Actor.gd`, `Player.gd`, `Enemy.gd`)
- **Component** → Child nodes storing data and emitting signals  
- **System** → Scripts that handles how a scene works (e.g., `BattleScene.gd`)

### 🔹 Auto-Battle (ATB) Combat
The combat system took inspiration from Final Fantasy, Pokemon and a little bit of DoTA mixed in.
Combat flow:
1. Gauge fills over time based on agility  
2. When full → `turn_ready` signal  
3. Actor switches to ATTACK state  
4. Plays attack animation  
5. Deals damage to opponent  
6. Gauge resets → returns to IDLE  
7. BattleScene checks win/lose condition

Future updates:
- Skills
- Equipments
- Levels

---

