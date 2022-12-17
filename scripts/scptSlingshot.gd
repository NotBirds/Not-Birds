extends Node2D
var can_be_used = false;
var mouse_pos
onready var top_sling = $lTop_sling
onready var down_sling = $Sprite/lDown_sling
onready var sling_center = $pCenter

func _ready():
    top_sling.hide()
    down_sling.hide()
    sling_center = sling_center.position #if the sling is going to move, remember to update this poss

func _process(_delta):
    if !can_be_used:
        return

func _input(event):
    if !can_be_used:
        return
    if Input.is_action_pressed("leftMouse"):
            mouse_pos = get_local_mouse_position()
            top_sling.show()
            down_sling.show()
            if mouse_pos.distance_to(sling_center) > 1000:
                mouse_pos = ((mouse_pos - sling_center).normalized() * 1000  + sling_center)
            top_sling.points[0] = mouse_pos
            down_sling.points[0] = mouse_pos
    else:
        top_sling.hide()
        down_sling.hide()
        can_be_used = false
            
func _on_aSlingshot_Hitbox_input_event(viewport, event, shape_idx):
    can_be_used = true

