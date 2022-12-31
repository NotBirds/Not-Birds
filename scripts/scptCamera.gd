extends Camera2D

onready var target_pos: Vector2 = position
onready var target_zoom: Vector2 = zoom


func _physics_process(_delta):
	position = lerp(position, target_pos, 0.03)
	zoom = lerp(zoom, target_zoom, 0.03)

func _on_checkpoint_player_advanced(new_pos: Vector2, new_zoom: Vector2):
	target_pos = new_pos
	target_zoom = new_zoom
