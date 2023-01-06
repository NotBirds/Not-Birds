extends TextureProgress

onready var signal_manager = $"/root/SignalManager"

func _ready():
	signal_manager.connect("player_damaged", self, "_on_player_damaged")

func _on_player_damaged(health):
	value = health
