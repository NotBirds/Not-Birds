extends RigidBody2D

var dead = false;

func _on_Timer_timeout():
	$audioDeath.play()
	$sprite.visible = false;
	$csHitbox.set_deferred("disabled", true)
	dead = true

func _process(delta):
	if dead && !$audioDeath.playing:
		queue_free()
