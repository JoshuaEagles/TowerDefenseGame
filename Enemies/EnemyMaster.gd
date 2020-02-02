extends Node2D

signal new_enemy #pass the enemy just created
signal enemy_killed #pass the enemy about to be killed

onready var green_slime = preload("res://Enemies/GreenSlime.tscn")

var spawn_timer_max = 5
var spawn_timer

func _ready():
	spawn_timer = 0
	
#	var enemy = green_slime.instance()
#	$SpawnedEnemies.add_child(enemy)
#	enemy.init($EnemySpawnPoints/SpawnPoint.position)
#	emit_signal("new_enemy",  enemy)

func _process(delta):
	spawn_timer -= delta 
	
	if spawn_timer <= 0:
		spawn_timer_max -= 0.01
		spawn_timer = spawn_timer_max
		
		var spawn_point = randi()%$EnemySpawnPoints.get_child_count()
		if spawn_point > 23:
			spawn_point = 23
		elif spawn_point < 0:
			spawn_point = 0
		
		var enemy = green_slime.instance()
		enemy.spawn_point = $EnemySpawnPoints.get_child(floor(spawn_point)).position
		$SpawnedEnemies.add_child(enemy)
		enemy.init()
		emit_signal("new_enemy",  enemy)

func kill_enemy(enemy : Node2D):
	emit_signal("enemy_killed", enemy)
	enemy.queue_free()
