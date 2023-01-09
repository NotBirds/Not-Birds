extends Node2D

export(int, 100) var enemy_count

onready var signal_manager = $"/root/SignalManager"

onready var start_audio = $start_audio

func _on_fight_mode_init_body_entered(_body):
	signal_manager.emit_signal("fight_mode", true)
	start_audio.play()

func _on_bird_killer_body_entered(body):
	signal_manager.emit_signal("respawn_player")
