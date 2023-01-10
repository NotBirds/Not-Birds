extends Node2D

onready var signal_manager = $"/root/SignalManager"

onready var start_audio = $start_audio
onready var win_audio = $win_audio
onready var enemies = $enemies
onready var bird_killer: BirdKiller = $bird_killer

func _on_fight_mode_init_body_entered(_body):
	signal_manager.emit_signal("fight_mode", true)
	start_audio.play()

# Called each time an enemy is killed
func _on_enemies_child_exiting_tree(_node):
	# The signal is triggered BEFORE the enemy is killed
	if enemies.get_child_count() <= 1:
		signal_manager.emit_signal("fight_mode", false)
		bird_killer.enabled = false
		win_audio.play()
	print(enemies.get_child_count())
