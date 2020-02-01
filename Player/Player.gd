extends KinematicBody2D

const SPEED = 400#200

var velocity = Vector2()

onready var enemy_notifier = preload("res://Player/EnemyNotifier.tscn")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	for enemy_notifier in $EnemyNotifiers.get_children():
		var enemy = enemy_notifier.associated_enemy.get_child(0)
		enemy_notifier.visible = !enemy.get_node("VisibilityNotifier2D").is_on_screen()
		if !enemy.get_node("VisibilityNotifier2D").is_on_screen():
			var player_enemy_difference = position - enemy.position
			enemy_notifier.rotation = atan2(-player_enemy_difference.x, player_enemy_difference.y)
	
	velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	velocity.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	
	if (velocity.length() > 1):
		velocity = velocity.normalized()
	
	move_and_slide(velocity * SPEED)
	
	$Cursor.set_as_toplevel(true)
	$Cursor.position = $Camera2D.get_global_mouse_position()
	
	if (Input.is_action_pressed("menu_action")):
		var newTrap = load("res://SimpleTrap.tscn").instance()
		newTrap.set_as_toplevel(true)
		newTrap.setup($Camera2D.get_global_mouse_position())
		add_child(newTrap)

func _on_Enemy_Master_new_enemy(enemy : Node2D):
	var instanced_notifier = enemy_notifier.instance()
	$EnemyNotifiers.add_child(instanced_notifier)
	instanced_notifier.associated_enemy = enemy

func _on_Enemy_Master_enemy_killed(enemy : Node2D):
	for enemy_notifier in $EnemyNotifiers.get_children():
		if enemy_notifier.associated_enemy == enemy:
			enemy_notifier.queue_free()
