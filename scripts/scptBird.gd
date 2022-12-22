extends RigidBody2D

func _on_Timer_timeout():
	$audioDeath.play()
	$sprite.visible = false;
	$csHitbox.set_deferred("disabled", true)
	yield($audioDeath, "finished")
	queue_free()
