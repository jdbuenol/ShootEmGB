extends KinematicBody2D

var speed : float = 0
var rng : int = 0

const ENEMY_BULLET : PackedScene = preload("res://enemies/enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = rand_range(-0.2, 1.5)
	$Sprite2.visible = false
	$AnimationPlayer.play("enemy")

#This executes every frame
func _physics_process(_delta):
	position.x += speed
	if rng == 1:
		position.y += speed / 2
	elif rng == 2:
		position.y -= speed / 2
	if position.y >= 140:
		position.y = 140
	elif position.y <= 4:
		position.y = 4

# basic enemy die from one hit
func get_hurt():
	get_parent().score += 100
	get_parent().check_score()
	$Sprite2.visible = true
	$AnimationPlayer.queue_free()
	$Sprite.queue_free()
	$AttackTimer.queue_free()
	$CollisionShape2D.queue_free()
	$AnimationPlayer2.play("death")

#queue free when animation of death ends
func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()

#when the enemy enters the screen it starts attacking
func _on_VisibilityNotifier2D_screen_entered():
	$AttackTimer.start()

#queue free when the enemy exits the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#Timer to when shoot
func _on_AttackTimer_timeout():
	var enemy_bullet : Area2D = ENEMY_BULLET.instance()
	get_parent().add_child(enemy_bullet)
	enemy_bullet.global_position = $Position2D.global_position

#Timer to when to change direction
func _on_directionTimer_timeout():
	rng = int(rand_range(0, 3))
	$directionTimer.start()
