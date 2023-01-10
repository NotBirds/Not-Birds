class_name BirdKiller
extends Area2D

export var enabled = true

onready var signal_manager = $"/root/SignalManager"

func _on_bird_killer_body_entered(body):
	if body is RigidBody2D:
		if enabled && body.get_collision_layer_bit(1):
			signal_manager.emit_signal("respawn_player")
		elif body is Destroyable:
			body.die()
