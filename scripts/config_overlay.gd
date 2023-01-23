extends Control

onready var master_vol_slider: Slider = $config_window/Audio/master_vol_slider
onready var music_vol_slider: Slider = $config_window/Audio/music_vol_slider
onready var sfx_vol_slider: Slider = $config_window/Audio/sfx_vol_slider

onready var master_bus_index = AudioServer.get_bus_index("Master")
onready var music_bus_index = AudioServer.get_bus_index("Music")
onready var sfx_bus_index = AudioServer.get_bus_index("Effects")

func _ready():
	master_vol_slider.value = AudioServer.get_bus_volume_db(master_bus_index)
	music_vol_slider.value = AudioServer.get_bus_volume_db(music_bus_index)
	sfx_vol_slider.value = AudioServer.get_bus_volume_db(sfx_bus_index)


func _on_master_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus_index, value)


func _on_music_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus_index, value)


func _on_sfx_vol_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus_index, value)


func _on_close_pressed():
	queue_free()
