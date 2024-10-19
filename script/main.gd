extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	home()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	pass

func home() ->void:
	if $menu:$menu.queue_free()
	var homepre = preload("res://secne/Home.tscn") # 替换为.tscn文件的路径
	var home=homepre.instantiate()
	$".".add_child(home)
	$swooshing.play()
	home.get_node("TextureButton").connect("button_up",start)
	pass
	
func start()->void:
	var beginpre = preload("res://secne/Begin.tscn") # 替换为.tscn文件的路径
	var begin=beginpre.instantiate()
	$Home.queue_free()
	$".".add_child(begin)
	$swooshing.play()
	begin.connect("start_tab",on_tab)
	pass

func on_tab()->void:
	var gamepre = preload("res://secne/Game.tscn") # 替换为.tscn文件的路径
	var game=gamepre.instantiate()
	$begin.queue_free()
	$".".add_child(game)
	game.connect("game_over",end_game)
	pass
	
func end_game()->void:
	var pre = preload("res://secne/menu.tscn") # 替换为.tscn文件的路径
	var menu=pre.instantiate()
	menu.set_information($Game.score)	
	$Game.queue_free()
	$swooshing.play()
	$".".add_child(menu)
	menu.get_node("menu").connect("button_up",home)
	menu.get_node("share").connect("button_up",home)
	pass 
