extends MarginContainer

enum buttonNames {START_BUTTON, EXIT_BUTTON}
var buttons# = ["StartButton", "ExitButton"]
var current_button = 0

func _ready():
	buttons = [get_node("VBoxContainer/VBoxContainer/StartButton"), get_node("VBoxContainer/VBoxContainer/ExitButton")]

	# get_node("VBoxContainer/VBoxContainer/StartButton")
	# $VBoxContainer/StartButton

func _process(delta):
	for button in buttons:
		if button.pressed:
			button.action()
	
	if ($Selected.visible):
		if Input.is_action_just_pressed("menu_up"):
			current_button += 1
		elif Input.is_action_just_pressed("menu_down"):
			current_button -= 1
		current_button = current_button % buttons.size()
		
		if (Input.is_action_just_pressed("menu_action")):
			buttons[current_button].action()
	else:
		if (Input.is_action_just_pressed("menu_action") or Input.is_action_just_pressed("menu_up") or Input.is_action_just_pressed("menu_down")):
			$Selected.visible = true
		
	$Selected.position = buttons[current_button].rect_global_position
	$Selected.position.x -= 100
	$Selected.position.y += 50
			
