extends Node2D

var health : float 
var DAMAGE_AMOUNT : float
var active : bool

func _ready():
	pass # Replace with function body.

func _process(delta):
	if $TriggerRadius.get_overlapping_areas().size() == 0:
		active = false
	
	for area in $TriggerRadius.get_overlapping_areas():
		var enemy = area.get_parent().get_parent()
		if enemy is Enemy_Base:
			active = true
		
	if active:
		for area in $EffectRadius.get_overlapping_areas():
			var enemy = area.get_parent().get_parent()
			if enemy is Enemy_Base:
				enemy.ouch(60*delta)

func setup(newPosition : Vector2):
	position = newPosition
