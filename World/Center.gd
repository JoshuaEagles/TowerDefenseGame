extends Node2D

func _process(delta):
	for area in $Area2D.get_overlapping_areas():
		if area.get_parent().get_parent() is Enemy_Base:
			area.get_parent().get_parent().kill()
