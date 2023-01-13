extends Camera2D

onready var target_pos: Vector2 = position
onready var target_zoom: Vector2 = zoom

onready var signal_manager = $"/root/SignalManager"
onready var state_manager = $"/root/StateManager"

export(NodePath) var player_path

var player: Node2D

func _ready():
	signal_manager.connect("move_camera", self, "_on_move_camera")
	signal_manager.connect("fight_mode", self, "_on_fight_mode_change")
	player = get_node(player_path)

func _physics_process(_delta):
	if state_manager.fighting:
		position = lerp(position, target_pos, 0.03)
	zoom = lerp(zoom, target_zoom, 0.03)

func _on_move_camera(new_pos: Vector2, new_zoom: Vector2):
	target_pos = new_pos
	target_zoom = new_zoom

func set_static_pos(fighting: bool):
	if fighting:
		var root = get_tree().get_root()
		get_parent().remove_child(self)
		root.add_child(self)
		global_position = player.global_position
	else:
		get_parent().remove_child(self)
		player.add_child(self)
		position = Vector2.ZERO

func _on_fight_mode_change(fighting: bool):
	call_deferred("set_static_pos", fighting)
