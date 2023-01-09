extends Area2D

onready var signal_manager = $"/root/SignalManager"

func _on_player_checkpoint_body_entered(body: Node2D):
	signal_manager.emit_signal("change_spawnpoint", body.global_position)
