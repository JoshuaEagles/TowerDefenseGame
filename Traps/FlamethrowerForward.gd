extends TrapBase

func _ready():
	#element = trap_master.elements.fire
	
	MAX_HEALTH = 250
	health = MAX_HEALTH
	
	$ProgressBarContainer/ProgressBar.max_value = MAX_HEALTH
	$ProgressBarContainer/ProgressBar.value = health
	
	damage_amount_per_second = 60
	self_damage_per_second = 15

func _process(delta):
	var enemies_in_range = .find_stuff_to_ouch()
	if enemies_in_range:
		for enemy in enemies_in_range:
			if enemy is Enemy_Base:
				enemy.ouch(damage_amount_per_second * delta)
		.ouch(self_damage_per_second * delta)
		$Sprite/Effects.visible = true 
	else:
		$Sprite/Effects.visible = false

	$ProgressBarContainer/ProgressBar.value = health
	$ProgressBarContainer.rotation = -rotation
