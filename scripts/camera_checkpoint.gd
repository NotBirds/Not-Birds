extends Node2D

export(Vector2) var new_zoom = Vector2(1.0, 1.0)

onready var signal_manager = $"/root/SignalManager"

func _on_activation_area_body_entered(_body):
	signal_manager.emit_signal(
		"move_camera",
		$camera_destination.global_position,
		new_zoom)
