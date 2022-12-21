extends Node
func _ready():
	pass # Replace with function body.

func audio_managment(chanel,file,volume,pitch,attenuation):  #0,"",0,1,1
	var song : AudioStream = load(file)
	$audio_channels.get_child(chanel).set_stream(song)
	$audio_channels.get_child(chanel).play()
	$audio_channels.get_child(chanel).set_volume_db(volume)
	$audio_channels.get_child(chanel).set_pitch_scale(pitch)
	$audio_channels.get_child(chanel).set_attenuation(attenuation)

func queue_audio(file,volume,pitch,attenuation):
	var chanel = 0
	while chanel <= 5 and $audio_channels.get_child(chanel).is_playing() == true:
		print($audio_channels.get_child(chanel).is_playing(), "  ", chanel)
		chanel = chanel + 1
	if chanel == 6:
		return 10
	self.audio_managment(chanel,file,volume,pitch,attenuation)
	return chanel
