extends CanvasLayer

onready var pause_button: Button = $buttons/pause
onready var pause_overlay: ColorRect = $pause_overlay

var config_overlay = preload("res://scenes/ui/config_overlay.tscn")

func _on_pause_toggled(button_pressed):
	if button_pressed:
		pause_button.text = "Resume"
	else:
		pause_button.text = "Pause"
	get_tree().paused = button_pressed
	pause_overlay.visible = button_pressed

func _on_configuration_pressed():
	var config_instance = config_overlay.instance()
	add_child(config_instance)
