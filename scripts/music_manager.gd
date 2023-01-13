extends AudioStreamPlayer
export(AudioStream) var default
export(AudioStream) var fighting

onready var crossfade_player: AudioStreamPlayer = $crossfade_player
onready var crossfade_animation = $crossfade_animation

onready var signal_manager = $"/root/SignalManager"

func _ready():
	signal_manager.connect("fight_mode", self, "_on_fight_mode")
	stream = default
	play()
		
func _on_fight_mode(fight):
	if fight:
		crossfade_player.stream = fighting
	else:
		crossfade_player.stream = default
	crossfade_player.play()
	crossfade_animation.play("crossfade")
	yield(crossfade_animation, "animation_finished")
	crossfade_animation.play("RESET")
	stop()
	stream = crossfade_player.stream
	play(crossfade_player.get_playback_position())
	crossfade_player.stop()
