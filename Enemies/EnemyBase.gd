extends Node

var center : Vector2
var spawn_point : Vector2
var pathPercent : float
var relativeTotalMovement : Vector2
var sinTime : float

class_name Enemy_Base

func init(spawn_point : Vector2):
	#spawn_point = Vector2(640, -640)#-640*/)
	self.spawn_point = spawn_point
	self.position = spawn_point
	center = get_tree().get_root().get_node("World/Center").position
	relativeTotalMovement = center - spawn_point
	
	pathPercent = 0
	sinTime = 0

func move_towards_center(delta : float, SPEED : float) -> void:
	pathPercent += delta * SPEED
	sinTime += delta * 5
	self.position = spawn_point + relativeTotalMovement * pathPercent
	self.position += relativeTotalMovement.rotated(deg2rad(90)).normalized() * sin(sinTime) * 10

func kill():
	var enemyMaster = get_parent().get_parent()
	enemyMaster.kill_enemy(self)
