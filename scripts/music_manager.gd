extends AudioStreamPlayer
export(AudioStream) var default
export(AudioStream) var fighting

onready var signal_manager = $"/root/SignalManager"

func _ready():
	signal_manager.connect("fight_mode", self, "_on_fight_mode")
	stream = default
	self.play()
		
func _on_fight_mode(fight):
	self.stop()
	if fight:
		stream = fighting
	else:
		stream = default
	self.play()
