extends Node2D

var trap_master

var element : int
var damage_amount_per_second
var self_damage_per_second

var MAX_HEALTH
var health

class_name TrapBase

func init(position : Vector2, rotation: float):
	self.position = position
	self.rotation = rotation

func find_stuff_to_ouch():
	var enemies_in_range = []
	for area in $OuchArea.get_overlapping_areas():
		var enemy = area.get_parent().get_parent()
		if enemy is Enemy_Base:
			enemies_in_range.append(enemy)
	return enemies_in_range
	
func ouch(self_damage_per_second : float):
	health -= self_damage_per_second
