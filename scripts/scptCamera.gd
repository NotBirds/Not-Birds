extends Camera2D
var can_be_used = true
const Dead_Zone = 80
onready var bird = preload("res://entities/scnBird.tscn")

func _ready():			 	#chanel,file,volume,pitch,attenuation
	Global.audio_managment(0,"res://assets/audio/Ambience - Copy.mp3",10,1,1)
#	Global.audio_managment(1,"res://assets/audio/Ambience - Copy.mp3",10,1,1)
	#Global.queue_audio("res://assets/audio/musica_de_la_tienda.mp3",-11,0.52,1)
	#Global.queue_audio("res://assets/audio/musica_de_la_tienda.mp3",-11,0.52,1)
	#Global.audio_managment(2,"res://assets/audio/musica_de_la_tienda.mp3",-11,0.52,1)
	print (Global.queue_audio("res://assets/audio/musica_de_la_tienda.mp3",-11,0.52,1))
func _input(event: InputEvent) -> void:
	if !can_be_used:
		return
	if event is InputEventMouseMotion:
		var _target = event.position - get_viewport().size * 0.04
		if _target.length() < Dead_Zone:
			self.position = Vector2(0,0)
		else:
			self.position = _target.normalized() * (_target.length() -  Dead_Zone) * 0.04
	if Input.is_action_pressed("rightMouse"):
		var selector = get_parent().get_node("scnBird.tscn")
		#self.position = selector

func _on_aLoock_mouse_entered():
	can_be_used = false

func _on_aLoock_mouse_exited():
	can_be_used = true
