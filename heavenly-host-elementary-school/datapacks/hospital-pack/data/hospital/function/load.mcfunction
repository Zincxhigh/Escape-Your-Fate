scoreboard objectives add lobby_timer dummy
scoreboard objectives add revive_timer dummy
scoreboard objectives add revive_progress dummy
scoreboard objectives add revive_sec dummy
scoreboard objectives add lobby_vars dummy
scoreboard objectives add deaths deathCount
scoreboard players set #20 lobby_vars 20

worldborder center 23 32
worldborder set 200
setworldspawn 30 68 52


gamemode adventure
tag @a remove tank
tag @a remove reviver
tag @a remove monster_detecter
tag @a remove is_monster
tag @a[limit=1,sort=random] add is_monster
tag @a[tag=!is_monster,limit=1,sort=random] add tank
tag @a[tag=!is_monster,tag=!tank,limit=1,sort=random] add reviver
tag @a[tag=!is_monster,tag=!tank,tag=!reviver,limit=1,sort=random] add monster_detecter

team add survivors "Survivors"
team add monster "Monster"
team modify survivors seeFriendlyInvisibles true
team modify survivors color blue
team modify monster color red
team join monster @a[tag=is_monster]
team join survivors @a[tag=tank]
team join survivors @a[tag=reviver]
team join survivors @a[tag=monster_detecter]


execute as @a[tag=is_monster] at @s run tp @s 23 63 32
execute as @a[tag=tank] at @s run tp @s 30 68 52
execute as @a[tag=reviver] at @s run tp @s 30 68 52
execute as @a[tag=monster_detecter] at @s run tp @s 30 68 52
title @a[tag=is_monster] title {"text":"You are KEVIN (hint) {%^&$^^$kILL^%^I WANNA KILL}","color":"red","bold": true}
title @a[tag=tank] title {"text":"You are leon (hint) Your way stronger and faster You know that right?","color":"white"}
title @a[tag=reviver] title {"text":"You are ZACH (hint) You can help them walk again","color":"green"}
title @a[tag=monster_detecter] title {"text":"You are MARIO (hint) You can sense unusual things near you:","color":"blue"}

