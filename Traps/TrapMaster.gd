extends Node2D

enum trap_names {flame_aoe, flame_forward}
onready var trap_types = [preload("FlamethrowerAOE.tscn"), preload("FlamethrowerForward.tscn")]
onready var trap_types_ghosts = [preload("FlamethrowerAOESprite.tscn"), preload("FlamethrowerForwardSprite.tscn")]
enum elements {fire, water}

var type_to_place : int = 0
var current_type : int
var rotation_to_place : float = 0

var ghost

func _ready():
	ghost = trap_types_ghosts[type_to_place].instance()
	current_type = type_to_place
	ghost.rotation = rotation_to_place
	
	add_child(ghost)
	
func _process(delta):
	if current_type != type_to_place:
		ghost.queue_free()
		ghost = trap_types_ghosts[type_to_place].instance()
		add_child(ghost)
		current_type = type_to_place
	
	ghost.rotation = rotation_to_place
	ghost.position = get_global_mouse_position()
	$RepairRadius.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("action"):
		var new_trap = trap_types[type_to_place].instance()
		new_trap.init(get_global_mouse_position(), rotation_to_place)
		$PlacedTraps.add_child(new_trap)
		
	if Input.is_action_pressed("action2"):
		for area in $RepairRadius.get_overlapping_areas():
			if area.get_parent() is TrapBase:
				area.get_parent().health += 100 * delta
	
	if Input.is_action_pressed("rotate_right"):
		rotation_to_place += 0.1
	elif Input.is_action_pressed("rotate_left"):
		rotation_to_place -= 0.1
		
	if Input.is_action_just_pressed("next_trap"):
		type_to_place += 1
	elif Input.is_action_just_pressed("prev_trap"):
		type_to_place -= 1

	type_to_place = type_to_place % trap_types.size()
