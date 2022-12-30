extends Node2D

export(NodePath) var camera_path
export(Vector2) var new_zoom = Vector2(1.0, 1.0)
onready var camera = get_node(camera_path)

signal move_camera(new_pos, new_zoom)

func _ready():
	connect("move_camera", camera, "_on_checkpoint_player_advanced")

func _on_activation_area_body_entered(_body):
	emit_signal(
		"move_camera",
		$camera_destination.global_position,
		new_zoom)
