extends RigidBody2D

func _on_Timer_timeout():
	Global.audio_managment(1,"res://assets/audio/dead.mp3",1,1,1,false)
	queue_free()
