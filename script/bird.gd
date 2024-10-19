extends RigidBody2D

@onready var animation: AnimatedSprite2D=$AnimatedSprite2D

@onready var audio_point: AudioStreamPlayer=$point
@onready var audio_swing: AudioStreamPlayer=$swing
@onready var audio_die: AudioStreamPlayer=$die
@onready var audio_hit: AudioStreamPlayer=$hit

@export var hp=3
@export var move_speed=50
@export var fly_speed=-300

signal no_hp
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity.x=move_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hp<=0:return
	if linear_velocity.y>=0:
		angular_velocity=5
		if rotation_degrees>=60:
			rotation_degrees=60
			angular_velocity=0
	else:
		angular_velocity=-5
		if rotation_degrees<=-30:
			rotation_degrees=-30
			angular_velocity=0
	if Input.is_action_just_pressed("bird_fly"):
		linear_velocity=Vector2(move_speed,fly_speed)
		audio_swing.play()
	
	#print(rotation_degrees)
#碰撞到物体
func _on_body_entered(body: Node) -> void:
	linear_velocity.x=move_speed
	audio_hit.play()
	hp-=1;
	if hp<=0:
		$die.play()
		emit_signal("no_hp")
		hp=0
		
