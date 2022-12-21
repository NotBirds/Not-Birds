extends RigidBody2D

export(float) var health = 1 #0.001 andaba
export(float) var death_treshold = 0.001
var death = false

export(float) var base_collision_pitch = 1
export(float) var base_destroy_pitch = 1

func _on_plank_body_entered(body):
	if body is RigidBody2D:
		var impact_velocity = (body.linear_velocity - self.linear_velocity).length()
		if impact_velocity > 1:
			Global.queue_audio("res://assets/audio/wood1.mp3",1,(base_collision_pitch + (impact_velocity * 0.012)),1,false)#file,volume,pitch,attenuation
			if impact_velocity > 80:
				damage(impact_velocity * body.mass * death_treshold)

func damage(value):
	health -= value
	$Sprite.modulate.g = health
	$Sprite.modulate.b = health
	if health <= 0:
		Global.queue_audio("res://assets/audio/wood2.mp3",1,(base_destroy_pitch + randf()),1,false)#file,volume,pitch,attenuation
		queue_free()
