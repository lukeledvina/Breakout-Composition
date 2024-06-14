extends Area2D

# on spawn, pick a random direction and go
# whenever it collides with the boundaries, reverse velocity of one direction, keep velocity in other direction the same
# if colliding with the paddle, depending on which side of the paddle, change velocity accordingly
var initial_pos: Vector2 = Vector2(320, 240)

var direction: Vector2 = Vector2.ZERO
var initial_speed: int = 100
var speed: int = initial_speed
var max_speed: int = 500
var speed_increment: int = 5
var velocity: Vector2
var player_width: int = 43

signal block_destroyed(score)
signal ball_destroyed()

func _ready():
	speed = initial_speed
	position = initial_pos
	
	await get_tree().create_timer(0.5).timeout
	
	direction = Vector2(randf_range(-0.9, 0.9), randf_range(0.1, 1)).normalized()

func _physics_process(delta):
	
	speed = min(speed, max_speed)
	
	velocity = direction * speed
	
	position += velocity * delta

func _on_area_left_body_entered(body):
	if body.is_in_group("Blocks"):
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		
	direction.x = -direction.x

func _on_area_up_body_entered(body):
	if body.is_in_group("Blocks"):
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		
	direction.y = -direction.y

func _on_area_down_body_entered(body):
	if body.is_in_group("Blocks"):
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		
	elif body.name == "Player":
		#reflect differently depending on what area of player hit
		var player_position_x: float = body.position.x
		var difference: float = clampf((player_position_x - position.x) / player_width, -0.8, 0.8)
		direction = Vector2(-difference, (1 - abs(difference))).normalized()
		
	elif body.is_in_group("DeathBoundary"):
		emit_signal("ball_destroyed")
		queue_free()
		
	direction.y = -direction.y
	

func _on_area_right_body_entered(body):
	if body.is_in_group("Blocks"):
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		
	direction.x = -direction.x
	
