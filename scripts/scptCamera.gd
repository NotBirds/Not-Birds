extends Camera2D
var can_be_used = true
const Dead_Zone = 80
var camera_speed

func _ready():			 	#chanel,file,volume,pitch,attenuation,loop
	Global.audio_managment(0,"res://assets/audio/Ambience - Copy.mp3",10,1,1,true)
	Global.queue_audio("res://assets/audio/musica_de_la_tienda.mp3",-11,0.52,1,true)
	
func _input(event: InputEvent) -> void:
	if !can_be_used:
		camera_speed = 0.013
	if event is InputEventMouseMotion:
		camera_speed =+ 0.02
		var _target = event.position - get_viewport().size * camera_speed
		if _target.length() < Dead_Zone:
			self.position = Vector2(0,0)
		else:
			self.position = _target.normalized() * (_target.length() -  Dead_Zone) * camera_speed
	if Input.is_action_pressed("rightMouse"):
		var selector = get_parent().get_node("scnBird.tscn")

func _on_aLoock_mouse_entered():
	can_be_used = false

func _on_aLoock_mouse_exited():
	can_be_used = true
