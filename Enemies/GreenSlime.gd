extends Enemy_Base
	
const SPEED = 1.0/5.0
const slime_colour = Color(146, 197, 117)
	
func _ready():
	pass
	
func _process(delta : float) -> void:
	if (!$Animated_Sprite.is_playing()):
		$Animated_Sprite/AnimationPlayer.play("Normal")
	.move_towards_center(delta, SPEED)

