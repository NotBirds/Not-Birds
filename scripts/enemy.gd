class_name Enemy
extends Destroyable

onready var signal_manager = $"/root/SignalManager"

func die():
	signal_manager.emit_signal("enemy_killed")
	if !$audioDestroy.playing:
		$audioDestroy.pitch_scale = base_destroy_pitch + randf()
		$audioDestroy.play()
	$Sprite.visible = false;
	$physicsCollider.set_deferred("disabled", true);
	yield($audioDestroy, "finished")
	queue_free()
