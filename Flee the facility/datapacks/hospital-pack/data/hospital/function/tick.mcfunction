# 1. EFFECTS
effect give @a[tag=!is_monster] regeneration 1 50 true
effect give @a saturation 1 100 true

effect give @a[tag=tank] speed 1 1 true
effect give @a[tag=tank] absorption 1 2 true

effect clear @a[team=monster] minecraft:glowing
effect clear @a[team=monster] minecraft:invisibility
effect give @a[team=survivors] minecraft:glowing 1 0 true

effect give @a[tag=is_monster] speed 1 2 true
effect give @a[tag=is_monster] night_vision 100 4 true
effect give @a[tag=is_monster] strength 1 4 true
effect give @a[tag=is_monster] regeneration 1 10 true

# Give the downed player the Glowing effect so the Medic can find them
effect give @a[tag=downed] minecraft:glowing 1 0 true

# 2. DOWNED EFFECTS & SPECTATOR FORCE
gamemode spectator @a[tag=downed,gamemode=!spectator]
effect give @a[tag=downed] minecraft:slowness 1 255 true
effect give @a[tag=downed] minecraft:jump_boost 1 200 true
effect give @a[tag=downed] minecraft:blindness 3 0 true

# 3. DETECTOR
execute as @a[tag=monster_detecter] at @s if entity @a[team=monster,distance=..10] run title @s actionbar {"text":"Something is close!","color":"red"}
execute as @a[tag=monster_detecter] at @s if entity @a[tag=is_monster,distance=..10] run playsound minecraft:block.note_block.snare ambient @s ~ ~ ~ 1 0.5

# 4. BORDERS
execute as @a[tag=tank,distance=100..] run tp @s 30 68 52
execute as @a[tag=monster_detecter,distance=100..] run tp @s 30 68 52
execute as @a[tag=reviver,distance=100..] run tp @s 30 68 52
execute as @a[tag=is_monster,distance=50..] run tp @s 23 65 32


# 5. DOWNED SYSTEM
execute as @a[scores={deaths=1..},tag=!is_monster] run tag @s add downed
execute as @a[tag=downed] run scoreboard players set @s deaths 0

# 6. BLEED OUT TIMER & MATH (Converts 1200 ticks to 60 seconds)
execute as @a[tag=downed,scores={revive_timer=0}] run scoreboard players set @s revive_timer 1200
scoreboard players remove @a[tag=downed,scores={revive_timer=1..}] revive_timer 1

# Convert ticks to seconds for the display
execute as @a[tag=downed] run scoreboard players operation @s revive_sec = @s revive_timer
scoreboard players set #20 lobby_vars 20
execute as @a[tag=downed] run scoreboard players operation @s revive_sec /= #20 lobby_vars

# Permanent Death Logic
execute as @a[tag=downed,scores={revive_timer=1}] run tellraw @a [{"selector":"@s","color":"red"},{"text":" has bled out!","color":"white"}]
execute as @a[tag=downed,scores={revive_timer=1}] run tag @s remove downed

# 7. REVIVE SYSTEM
execute as @a[tag=reviver] at @s as @a[tag=downed,distance=..2,limit=1] run tag @s add being_revived
execute as @a[tag=reviver] at @s as @a[tag=downed,distance=..2,limit=1] run scoreboard players add @s revive_progress 1

# Reset if reviver leaves
execute as @a[tag=downed] at @s unless entity @a[tag=reviver,distance=..2] run tag @s remove being_revived
execute as @a[tag=downed] at @s unless entity @a[tag=reviver,distance=..2] run scoreboard players set @s revive_progress 0

# Updated Actionbar: Shows Seconds (revive_sec) instead of ticks
title @a[tag=downed] actionbar ["",{"text":"Bleed Out: ","color":"red"},{"score":{"name":"@s","objective":"revive_sec"}},{"text":"s | ","color":"gray"},{"text":"Revive: ","color":"yellow"},{"score":{"name":"@s","objective":"revive_progress"}},{"text":"/60","color":"gold"}]

# Success Check
execute as @a[tag=downed,scores={revive_progress=60..}] run function hospital:revive_success

# 8. MARKER & FREEZING
execute as @a[tag=downed,tag=!placed_marker] at @s run summon marker ~ ~ ~ {Tags:["death_point"]}
execute as @a[tag=downed,tag=!placed_marker] run tag @s add placed_marker
execute as @a[tag=downed] at @s run tp @s @e[tag=death_point,limit=1,sort=nearest]

# Clean up marker/tags if revived
execute as @a[tag=being_revived] at @s if score @s revive_progress matches 60.. run kill @e[tag=death_point,distance=..3,limit=1]
execute as @a[tag=being_revived] at @s if score @s revive_progress matches 60.. run tag @s remove placed_marker
