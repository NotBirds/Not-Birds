class_name Destroyable
extends WithForce

export(float) var initial_health = 100.0
var health
export(float) var base_collision_pitch = 1.0
export(float) var base_destroy_pitch = 1.0

onready var collision = $collision
onready var audioCollision = $audioCollision
onready var audioDestroy = $audioDestroy
onready var sprite: Sprite = $sprite

func _on_plank_body_entered(body):
	if body is WithForce:
		var impact_force = get_impact_force() + body.get_impact_force()
		impact_force *= 0.001
		if impact_force > 1:
			if !audioCollision.playing:
				audioCollision.pitch_scale = base_collision_pitch + randf()
				audioCollision.play()
			#if impact_force > 80:
			damage(impact_force * pow(2, body.mass))

func _ready():
	health = initial_health
	audioCollision.pitch_scale = base_collision_pitch
	audioDestroy.pitch_scale = base_destroy_pitch

func damage(value):
	health -= value
	sprite.modulate.g = health/initial_health
	sprite.modulate.b = health/initial_health
	if health <= 0:
		die()

func die():
	if !audioDestroy.playing:
		audioDestroy.pitch_scale = base_destroy_pitch + randf()
		audioDestroy.play()
	sprite.visible = false;
	collision.set_deferred("disabled", true);
	yield(audioDestroy, "finished")
	queue_free()
