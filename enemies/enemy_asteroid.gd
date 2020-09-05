extends KinematicBody2D

var speed : float = 0
var second_speed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = load("res://assets/enemies/enemy_asteroid_" + str(get_parent().current_level) + ".png")
	randomize()
	rotation_degrees = rand_range(0, 360)
	speed = rand_range(-0.7, 1)

# This executes every frame
func _physics_process(_delta):
	position.x += speed

#Asteroids are invicible
func get_hurt():
	pass
