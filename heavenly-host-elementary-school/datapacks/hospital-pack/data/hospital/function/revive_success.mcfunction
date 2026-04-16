
scoreboard players set @s revive_progress 0
scoreboard players set @s revive_timer 0
tag @s remove downed
title @s title {"text":"REVIVED!","color":"green"}
playsound minecraft:entity.player.levelup player @a ~ ~ ~ 1 1
gamemode survival

