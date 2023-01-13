extends Area2D

class AlienMaterial:
	var name: String
	var icon: Sprite

enum Materials {
	WOOD,
	STONE,
	METAL
}

export(Array, Materials) var materials

onready var signal_manager = $"/root/SignalManager"

func _on_player_checkpoint_body_entered(body: Node2D):
	signal_manager.emit_signal("change_spawnpoint", body.global_position)

# func _ready():
#	for item in materials:
#		$ItemList.add_item(item)
