extends Node2D

var best:int=0
var score:int=0;

# 假设你的数字图片已经按照顺序加载到了一个字典中
var digits_images = {
	"0": load("res://picture/number_large_0.png"),
	"1": load("res://picture/number_large_1.png"),
	"2": load("res://picture/number_large_2.png"),
	"3": load("res://picture/number_large_3.png"),
	"4": load("res://picture/number_large_4.png"),
	"5": load("res://picture/number_large_5.png"),
	"6": load("res://picture/number_large_6.png"),
	"7": load("res://picture/number_large_7.png"),
	"8": load("res://picture/number_large_8.png"),
	"9": load("res://picture/number_large_9.png"),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_texture_button_button_up() ->void:
	print("排名")
	
	pass # Replace with function body.


# 函数：根据给定的数值，将对应的数字图片拼接成一张图片
func create_number_image(number:int)->Image:
	# 将数字转换为字符串，以便可以迭代每个字符
	var number_str = str(number)
	var total_width = 0
	var max_height = 0
	
	# 计算新图片所需的宽度和高度
	for digit in number_str:
		var image = digits_images[digit]
		total_width += image.get_width()
		max_height = max(max_height, image.get_height())
	
	# 创建一个新的Image对象
	var new_image = Image.new()
	new_image.create(total_width, max_height, false, Image.FORMAT_RGBA8)
	
	# 将每个数字图片复制到新图片的正确位置上
	var current_x = 0
	for digit in number_str:
		var image = digits_images[digit]
		new_image.blit_rect(image, Rect2(0, 0, image.get_width(), image.get_height()), Vector2(current_x, 0))
		current_x += image.get_width()
	
	## 将新的Image对象转换回Texture2D
	#var new_texture = ImageTexture.new()
	#new_texture.create_from_image(new_image)
	
	return new_image

func set_information(score:int)->void:
	self.score=score
	if score>best:
		best=score
	
	var pic=create_number_image(score)
	if pic:
		$PanelScore/score.texture=pic
	else:
		print("pic ==null")
	pass
