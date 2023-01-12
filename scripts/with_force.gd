# This class is for all objects that need to calculate force of impact
# (such as planks and the player)
class_name WithForce
extends RigidBody2D

onready var last_velocity: Vector2 = linear_velocity
var impact_force = 0.0

func _physics_process(_delta):
	last_velocity = linear_velocity

func get_impact_force():
	return (linear_velocity - last_velocity).length_squared()
