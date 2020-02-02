extends Enemy_Base
	
onready var progress_bar = $GreenSlimePathFollow/ProgressBar
onready var animated_sprite = $GreenSlimePathFollow/AnimatedSprite
	
func _ready():
	SPEED = 1500
	SLIME_COLOUR = Color(0.573, 0.773, 0.359)
	
	can_move = true
	
	max_health = 100
	health = max_health
	progress_bar.max_value = max_health 
	progress_bar.value = health
	
func _process(delta : float) -> void:
	.general_process()
	
	var speedMultiplier = 1
	if ouched:
		speedMultiplier = 0.7
	.move_towards_center(delta * speedMultiplier)
	
	progress_bar.value = health
	
	if (!animated_sprite.is_playing()):
		animated_sprite.get_node("AnimationPlayer").play("Normal")
