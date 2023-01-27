extends Control

onready var config_overlay = preload("res://scenes/ui/config_overlay.tscn")

func _on_start_game_pressed():
	get_tree().change_scene("res://scenes/levels/level1.tscn")


func _on_configuration_pressed():
	var config = config_overlay.instance()
	add_child(config)
