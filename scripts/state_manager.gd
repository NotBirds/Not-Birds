extends Node

export var fighting = false;

onready var signal_manager = $"/root/SignalManager"

func _ready():
	signal_manager.connect("fight_mode", self, "_on_set_fighting")

func _on_set_fighting(value: bool):
	fighting = value
