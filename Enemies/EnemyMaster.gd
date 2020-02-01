extends Node2D

signal new_enemy #pass the enemy just created
signal enemy_killed #pass the enemy about to be killed

onready var green_slime = preload("res://Enemies/GreenSlime.tscn")

func _ready():
	var enemy = green_slime.instance()
	$SpawnedEnemies.add_child(enemy)
	enemy.init($EnemySpawnPoints/SpawnPointN.position)
	emit_signal("new_enemy",  enemy)

#	enemy = green_slime.instance()
#	$SpawnedEnemies.add_child(enemy)
#	enemy.init($EnemySpawnPoints/SpawnPointN.position)
#	emit_signal("new_enemy", enemy)

func kill_enemy(enemy : Node2D):
	emit_signal("enemy_killed", enemy)
	enemy.queue_free()
