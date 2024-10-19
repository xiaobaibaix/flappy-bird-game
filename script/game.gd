extends Node2D

@export var delta_x=10
@export var delta_y=100

var id_pip:int=1
var player_pos: Vector2
var score:int=0
signal  game_over
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_pos=$bird.position
	$bk/pips/Pip.get_node("VisibleOnScreenNotifier2D").connect("screen_exited",_on_move_out)
	$bk/pips/Pip2.get_node("VisibleOnScreenNotifier2D").connect("screen_exited",_on_move_out)
	$bk/pips/Pip3.get_node("VisibleOnScreenNotifier2D").connect("screen_exited",_on_move_out)
	$bk/pips/Pip4.get_node("VisibleOnScreenNotifier2D").connect("screen_exited",_on_move_out)
	$bk/pips/Pip5.get_node("VisibleOnScreenNotifier2D").connect("screen_exited",_on_move_out)
	$bird.connect("no_hp",on_no_hp)
	$bk/pips/Pip.get_node("Area2D").connect("body_entered",on_fly_out)
	$bk/pips/Pip2.get_node("Area2D").connect("body_entered",on_fly_out)
	$bk/pips/Pip3.get_node("Area2D").connect("body_entered",on_fly_out)
	$bk/pips/Pip4.get_node("Area2D").connect("body_entered",on_fly_out)
	$bk/pips/Pip5.get_node("Area2D").connect("body_entered",on_fly_out)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.translate(Vector2($bird.position.x-player_pos.x,0))
	player_pos=$bird.position
	
	pass

func _on_move_out()->void:
	match id_pip:
		1:
			$bk/pips/Pip.init($Camera2D.position,randi_range(-delta_x,delta_x),randi_range(-delta_y,delta_y))
		2:
			$bk/pips/Pip2.init($Camera2D.position,randi_range(-delta_x,delta_x),randi_range(-delta_y,delta_y))
		3:
			$bk/pips/Pip3.init($Camera2D.position,randi_range(-delta_x,delta_x),randi_range(-delta_y,delta_y))
		4:
			$bk/pips/Pip4.init($Camera2D.position,randi_range(-delta_x,delta_x),randi_range(-delta_y,delta_y))
		5:
			$bk/pips/Pip5.init($Camera2D.position,randi_range(-delta_x,delta_x),randi_range(-delta_y,delta_y))
	id_pip+=1
	if(id_pip>=6):id_pip=1
	pass
	
func on_no_hp()->void:
	$bird.gravity_scale=0
	$bird.linear_velocity.x=0
	$bird.linear_velocity.y=0
	var endpre=preload("res://secne/end.tscn")
	var end=endpre.instantiate()
	end.position=Vector2($Camera2D.position.x,$Camera2D.position.y-50)
	$".".add_child(end)
	end.get_node("TextureButton").connect("button_up",on_game_over)
	pass
	
func on_game_over()->void:
	emit_signal("game_over")
	pass

func on_fly_out(body: Node2D)->void:
	print("entry")
	$bird.get_node("point").play()
	score+=1
	pass
