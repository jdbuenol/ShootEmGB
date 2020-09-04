extends KinematicBody2D

var speed : float = 0
var rng : int = 0
var hit_points : int = 2
var hitted : bool = false
var flashing : int = 0

const ENEMY_BULLET : PackedScene = preload("res://enemies/enemy_bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	speed = rand_range(1.3, 3)
	$Sprite2.visible = false
	$AnimationPlayer.play("default")

#This executes every frame
func _physics_process(_delta):
	if hitted:
		flashing += 1
		if flashing == 5:
			flashing = 0
			$Sprite.visible = !$Sprite.visible
	position.x += speed
	if rng == 1:
		position.y += speed / 3.0
	elif rng == 2:
		position.y -= speed / 3.0
	if position.y >= 130:
		position.y = 130
	elif position.y <= 14:
		position.y = 14

# this enemy die from 2 hits
func get_hurt():
	if !hitted:
		hit_points -= 1
		if hit_points <= 0:
			get_parent().score += 200
			get_parent().check_score()
			$Sprite2.visible = true
			$AnimationPlayer.queue_free()
			$Sprite.queue_free()
			$AttackTimer.queue_free()
			$CollisionShape2D.queue_free()
			$Particles2D.queue_free()
			$AnimationPlayer2.play("death")
		else:
			hitted = true
			$hittedTimer.start()

# Queue free at end of death
func _on_AnimationPlayer2_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()

#	Timer to when shoot
func _on_AttackTimer_timeout():
	var enemy_bullet : Area2D = ENEMY_BULLET.instance()
	get_parent().add_child(enemy_bullet)
	enemy_bullet.global_position = $Position2D.global_position

# Timer to when to change direction
func _on_directionTimer_timeout():
	rng = int(rand_range(0, 3))
	$directionTimer.start()

# Start attacking when screen entered
func _on_VisibilityNotifier2D_screen_entered():
	$AttackTimer.start()

# when to stop hitting
func _on_hittedTimer_timeout():
	hitted = false
	$Sprite.visible = true

# too much time in screen is dead
func _on_screenTimer_timeout():
	queue_free()
