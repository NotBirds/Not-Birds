extends Node2D

export(NodePath) var slingshot_path
export(float) var minimum_distance = 200.0
var slingshot_height
var slingshot_center
onready var slingshot: Node2D = get_node(slingshot_path)

signal move_slingshot(new_pos)

func _ready():
	# Connect signal automatically to the slingshot
	connect("move_slingshot", slingshot, "_on_move_slingshot")
	
	# Get the size of the slingshot sprite for centering
	var slingshot_sprite: Sprite = slingshot.get_node("sTexture")
	var slingshot_center_pos: Position2D = slingshot.get_node("pCenter")
	slingshot_center = slingshot_center_pos.position.y
	slingshot_height = slingshot_sprite.texture.get_size().y * slingshot_sprite.scale.y

func _on_activation_area_body_entered(body: Node2D):
	# See if the new position is far enough before moving the slingshot
	var distance = (slingshot.position - body.position).length_squared()
	if distance > pow(minimum_distance, 2):
		var offset = Vector2(0.0, - slingshot_height / 2) # To center the sprite
		var new_pos = Vector2(body.position.x, $activation_area.global_position.y)
		emit_signal("move_slingshot", new_pos + offset)
