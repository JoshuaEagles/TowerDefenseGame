extends Node2D

var health : float 
var DAMAGE_AMOUNT : float
var active : bool

func _ready():
	pass # Replace with function body.

func _process(delta):
	for body in $TriggerRadius.get_overlapping_bodies():
		if body is Enemy_Base:
			active = true
			
	if $TriggerRadius.get_overlapping_bodies().size() == 0:
		active = false
		
	if active:	
		for body in $EffectRadius.get_overlapping_bodies():
			if body is Enemy_Base:
				body.can_move = false
				body.ouch(60*delta)

func setup(newPosition : Vector2):
	position = newPosition
