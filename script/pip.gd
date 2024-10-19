extends Node2D

@export var h=140#水管的垂直间距
@export var w=50#水管的水平间距


var sreen_w_x=288
var sreen_w_y=512


func init(sreen_pos:Vector2,sreen_delta_x:int,sreen_delta_y:int) -> void:
	position.x=sreen_pos.x+sreen_w_x/8+sreen_delta_x
	position.y=sreen_delta_y
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.y=scale.y/140*h
	var delta_=140-h
	translate(Vector2(0,delta_))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
