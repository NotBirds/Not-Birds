extends AnimationPlayer

onready var signal_manager = $"/root/SignalManager"

func _ready():
	signal_manager.connect("fight_mode", self, "_set_fight_mode")

func _set_fight_mode(fighting: bool):
	if fighting:
		play("fight_enable")
		self.queue("fighting")
	else:
		play("fight_disable")
		self.queue("REST")
