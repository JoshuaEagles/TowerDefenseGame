extends Node

var SPEED : float
var SLIME_COLOUR : Color

var can_move : bool

var center : Vector2
var spawn_point : Vector2
var pathPercent : float
var relativeTotalMovement : Vector2
var sinTime : float
var max_health
var health

class_name Enemy_Base

func init(spawn_point : Vector2):
	self.spawn_point = spawn_point
	#self.position = spawn_point
	center = get_tree().get_root().get_node("World/Center").position
	var pathArray = get_tree().get_root().get_node("World/Navigation2D").get_simple_path(spawn_point, center)
	
	for vector in pathArray:
		self.curve.add_point(vector)
	
	#relativeTotalMovement = center - spawn_point
	
	pathPercent = 0
	sinTime = 0

func general_process():
	if health <= 0:
		kill()

func move_towards_center(delta : float) -> void:
	if !can_move:
		return
		
	self.get_node("GreenSlimePathFollow").offset += delta * SPEED
	
	#pathPercent += delta * SPEED
	#sinTime += delta * 5
	#self.position = spawn_point + relativeTotalMovement * pathPercent
	#self.position += relativeTotalMovement.rotated(deg2rad(90)).normalized() * sin(sinTime) * 10

func ouch(hurt_amount : float):
	health -= hurt_amount

func kill():
	var enemyMaster = get_parent().get_parent()
	enemyMaster.kill_enemy(self)
