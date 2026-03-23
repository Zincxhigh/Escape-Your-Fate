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
execute as @a[tag=monster_detecter] at @s if entity @a[team=monster,distance=..10] run title @s actionbar {"text":"Something is close!","color":"red","bold": true}
execute as @a[tag=monster_detecter] at @s if entity @a[tag=is_monster,distance=..10] run playsound minecraft:block.note_block.snare ambient @s ~ ~ ~ 1 0.5

# 4. BORDERS
execute as @a[tag=tank,x=3,z=3,distance=90..] run tp @s -54 -2 55
execute as @a[tag=monster_detecter,x=3,z=3,distance=90..] run tp @s -54 -2 55
execute as @a[tag=reviver,x=3,z=3,distance=90..] run tp @s -54 -2 55
execute as @a[tag=is_monster,x=3,z=3,distance=90..] run tp @s -2 -2 -43

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

execute as @a[x=-37,y=-2,z=37,distance=..5,tag=!played_once] at @s run playsound minecraft:creepy master @s[tag=!is_monster] -37 -2 37 1 1
tag @a[x=-37,y=-2,z=37,distance=..5,tag=!played_once] add played_once

execute as @a[x=-1,y=-2,z=24,distance=..5,tag=!played_twice] at @s run playsound minecraft:drum master @s[tag=!is_monster] -1 -2 24
tag @a[x=-1,y=-2,z=24,distance=..5,tag=!played_twice] add played_twice

execute as @a[x=-32,y=-2,z=17,distance=..5,tag=!played_three] at @s run playsound minecraft:drum master @s[tag=!is_monster] -32 -2 17 1 0.5
tag @a[x=-32,y=-2,z=17,distance=..5,tag=!played_three] add played_three

execute as @a[x=-10,y=4,z=11,distance=..5,tag=!played_four] at @s run playsound minecraft:creepy master @s[tag=!is_monster] -10 4 11 1 0.5
tag @a[x=-10,y=4,z=11,distance=..5,tag=!played_four] add played_four

execute as @a[x=-39,y=4,z=23,distance=..5,tag=!played_five] at @s run playsound minecraft:terror master @s[tag=!is_monster] -39 4 23 1
tag @a[x=-39,y=4,z=23,distance=..5,tag=!played_five] add played_five

