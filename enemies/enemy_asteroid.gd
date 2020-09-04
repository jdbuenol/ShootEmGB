extends KinematicBody2D

var speed : float = 0
var rot_speed : float = 0
var second_speed : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
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
