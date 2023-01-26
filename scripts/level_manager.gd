extends Node

var levels

func load_levels(json_path: String):
	var file = File.new()
	file.open("res://resources/")
