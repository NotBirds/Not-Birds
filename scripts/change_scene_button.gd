extends Button

export(String) var scene_path
func _on_start_game_pressed():
	get_tree().change_scene(scene_path)
