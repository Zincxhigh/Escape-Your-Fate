scoreboard objectives add lobby_timer dummy
scoreboard objectives add revive_timer dummy
scoreboard objectives add revive_progress dummy
scoreboard objectives add revive_sec dummy
scoreboard objectives add lobby_vars dummy
scoreboard objectives add skip_intro trigger
scoreboard objectives add intro_timer dummy
scoreboard objectives add hacked_computers dummy
scoreboard players set @a intro_timer 1
bossbar add hacking_progress "Hacking System..."
bossbar set hacking_progress color green
bossbar set hacking_progress style progress
scoreboard objectives add hacking_timer dummy
scoreboard objectives add sneak_check minecraft.custom:minecraft.sneak_time
scoreboard objectives add deaths deathCount
scoreboard players set #20 lobby_vars 20


worldborder center 25 34
worldborder set 500
setworldspawn -51 -3 52


gamemode survival
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
team modify survivors nametagVisibility never
team modify monster nametagVisibility never
team modify survivors color blue
team modify monster color red
team join monster @a[tag=is_monster]
team join survivors @a[tag=tank]
team join survivors @a[tag=reviver]
team join survivors @a[tag=monster_detecter]


execute as @a[tag=is_monster] at @s run tp @s -2 -2 -43
execute as @a[tag=tank] at @s run tp @s -54 -2 55
execute as @a[tag=reviver] at @s run tp @s -54 -2 55
execute as @a[tag=monster_detecter] at @s run tp @s -54 -2 55



give @a[tag=is_monster] minecraft:leather_chestplate[minecraft:dyed_color=0]
give @a[tag=is_monster] minecraft:leather_leggings[minecraft:dyed_color=0]
give @a[tag=is_monster] minecraft:leather_boots[minecraft:dyed_color=0]
give @a[tag=is_monster] minecraft:player_head[minecraft:custom_name='{"text":"Elder Mimic","color":"gold","underlined":true,"bold":true,"italic":false}',minecraft:lore=['{"text":"Custom Head ID: 111717","color":"gray","italic":false}','{"text":"www.minecraft-heads.com","color":"blue","italic":false}'],minecraft:profile={properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2U1Nzk2ZmI3MmI2OGUzNmQ0YmZmYjM2MThkNzNiZDNlODk3NTU4MjdkNGE4NjZmZDhhNGFkYTIzOTc3OWExNCJ9fX0="}]}] 1
give @a[tag=is_monster] minecraft:netherite_sword
give @a[tag=is_monster] minecraft:potion[minecraft:potion_contents={custom_effects:[{id:"minecraft:invisibility",amplifier:1,duration:1000,show_particles:0b}]}] 2

effect clear @a[team=monster] minecraft:invisibility 
effect clear @a[team=monster] minecraft:glowing












