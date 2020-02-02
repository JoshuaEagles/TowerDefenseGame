extends TrapBase

func _ready():
	#element = trap_master.elements.fire
	
	MAX_HEALTH = 200
	health = MAX_HEALTH
	
	$ProgressBar.max_value = MAX_HEALTH
	$ProgressBar.value = health
	
	damage_amount_per_second = 20
	self_damage_per_second = 25

func _process(delta):
	if health <= 0:
		$Sprite/Effects.visible = false
		$Sprite.play("Broken")
		return
	
	$Sprite.play("Working")
	
	var enemies_in_range = .find_stuff_to_ouch()
	if enemies_in_range:
		for enemy in enemies_in_range:
			if enemy is Enemy_Base:
				enemy.ouch(damage_amount_per_second * delta)
		.ouch(self_damage_per_second * delta)
		$Sprite.rotation += 2 * delta
		$Sprite/Effects.visible = true 
	else:
		$Sprite/Effects.visible = false

	$ProgressBar.value = health
