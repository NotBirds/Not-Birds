extends Node

func audio_managment(chanel,file,volume,pitch,attenuation,looping):  #0,"",0,1,1
	var song : AudioStream = load(file)
	$audio_channels.get_child(chanel).set_stream(song)
	$audio_channels.get_child(chanel).stream.loop = looping
	$audio_channels.get_child(chanel).play()
	$audio_channels.get_child(chanel).set_volume_db(volume)
	$audio_channels.get_child(chanel).set_pitch_scale(pitch)
	$audio_channels.get_child(chanel).set_attenuation(attenuation)

func queue_audio(file,volume,pitch,attenuation,looping):
	var chanel = 0
	while chanel <= 5 and $audio_channels.get_child(chanel).is_playing() == true:
		chanel = chanel + 1
	if chanel == 6:
		return 10
	self.audio_managment(chanel,file,volume,pitch,attenuation,looping)
	return chanel

func edit_audio(chanel,change_needed,value):
	match change_needed:
		"volume":
			$audio_channels.get_child(chanel).set_volume_db(value)
		"pitch":
			$audio_channels.get_child(chanel).set_pitch_scale(value)
		"attenuation":
			$audio_channels.get_child(chanel).set_attenuation(value)
		"change_track":
			$audio_channels.get_child(chanel).set_stream(value)
		"stop":
			$audio_channels.get_child(chanel).play()
		"loop":
			$audio_channels.get_child(chanel).stream.loop = value
