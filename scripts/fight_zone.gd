extends Node2D

onready var signal_manager = $"/root/SignalManager"

onready var start_audio: AudioStreamPlayer = $start_audio
onready var win_audio: AudioStreamPlayer = $win_audio
onready var enemies: Node = $enemies
onready var bird_killer: BirdKiller = $bird_killer
onready var new_spawnpoint: Position2D = $new_spawnpoint

func _on_fight_mode_init_body_entered(_body):
	if !start_audio.playing:
		signal_manager.emit_signal("fight_mode", true)
		signal_manager.emit_signal("change_spawnpoint", new_spawnpoint.global_position)
		signal_manager.emit_signal("go_to_spawn_and_freeze")
		bird_killer.enabled = true
		start_audio.play()

# Called each time an enemy is killed
func _on_enemies_child_exiting_tree(_node):
	# The signal is triggered BEFORE the enemy is killed
	if enemies.get_child_count() <= 1:
		signal_manager.emit_signal("fight_mode", false)
		bird_killer.enabled = false
		win_audio.play()
		yield(win_audio, "finished")
		queue_free()
	print(enemies.get_child_count())
