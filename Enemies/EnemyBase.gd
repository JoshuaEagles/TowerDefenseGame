extends Node

var SPEED : float
var SLIME_COLOUR : Color

var can_move : bool

var center : Vector2
var spawn_point : Vector2
var pathPercent : float
var relativeTotalMovement : Vector2
var max_health
var health

var ouched : bool

class_name Enemy_Base

func init(spawn_point : Vector2):
	self.spawn_point = spawn_point
	center = get_tree().get_root().get_node("World/Center").position
	
	self.get_node("GreenSlimePathFollow").position = Vector2(-100000, -100000)
	self.get_node("GreenSlimePathFollow").offset = 0
	
	var pathArray = get_tree().get_root().get_node("World/Navigation2D").get_simple_path(spawn_point, center, false)
	
	for vector in pathArray:
		self.curve.add_point(vector)
	
	pathPercent = 0

func general_process():
	if health <= 0:
		kill()

func move_towards_center(delta : float) -> void:
	if !can_move:
		return
		
	self.get_node("GreenSlimePathFollow").offset += delta * SPEED

func ouch(hurt_amount : float):
	health -= hurt_amount
	ouched = true

func kill():
	var enemyMaster = get_parent().get_parent()
	enemyMaster.kill_enemy(self)
