extends KinematicBody2D

var speed : float = 0
var rot_speed : float = 0
var second_speed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load("res://assets/enemies/enemy_asteroid_" + str(get_parent().current_level) + ".png")
	randomize()
	rot_speed = rand_range(2, -2)
	speed = rand_range(-0.7, 1)

# This executes every frame
func _physics_process(_delta):
	rotation_degrees += rot_speed
	position.x += speed

#Asteroids are invicible
func get_hurt():
	pass
