extends Enemy_Base
	
onready var progress_bar = $GreenSlimePathFollow/ProgressBar
onready var animated_sprite = $GreenSlimePathFollow/AnimatedSprite
	
func _ready():
	SPEED = 500
	SLIME_COLOUR = Color(146, 197, 117)
	
	can_move = true
	
	max_health = 100
	health = max_health
	progress_bar.max_value = max_health 
	progress_bar.value = health
	
func _process(delta : float) -> void:
	.general_process()
	.move_towards_center(delta)
	
	progress_bar.value = health
	
	if (!animated_sprite.is_playing()):
		animated_sprite.get_node("AnimationPlayer").play("Normal")
