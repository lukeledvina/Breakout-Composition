extends Area2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

var initial_pos: Vector2 = Vector2(320, 240)

var direction: Vector2 = Vector2.ZERO
var initial_speed: int = 100
var speed: int = initial_speed
var max_speed: int = 500
var speed_increment: int = 5
var velocity: Vector2
var player_width: int = 43

var can_destroy: bool = true

signal block_destroyed(score)
signal ball_destroyed()

@onready var cooldown_timer: Timer = $CooldownTimer

func _ready():
	speed = initial_speed
	position = initial_pos
	
	await get_tree().create_timer(1).timeout
	
	direction = Vector2(randf_range(-0.9, 0.9), randf_range(0.1, 1)).normalized()

func _physics_process(delta):
	
	speed = min(speed, max_speed)
	
	velocity = direction * speed
	
	position += velocity * delta

func _on_area_left_body_entered(body):
	if body.is_in_group("Blocks") && can_destroy:
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		can_destroy = false
		cooldown_timer.start()
		direction.x = -direction.x
	elif !can_destroy:
		pass
	else:
		direction.x = -direction.x
	audio_player.play()


func _on_area_up_body_entered(body):
	if body.is_in_group("Blocks") && can_destroy:
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		can_destroy = false
		cooldown_timer.start()
		direction.y = -direction.y
	elif !can_destroy:
		pass
	else:
		direction.y = -direction.y
	audio_player.play()

func _on_area_down_body_entered(body):
	if body.is_in_group("Blocks") && can_destroy:
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		can_destroy = false
		cooldown_timer.start()
		direction.y = -direction.y
	elif !can_destroy:
		pass
	elif body.name == "Player":
		#reflect differently depending on what area of player hit
		var player_position_x: float = body.position.x
		var difference: float = clampf((player_position_x - position.x) / player_width, -0.8, 0.8)
		direction = Vector2(-difference, (1 - abs(difference))).normalized()
		direction.y = -direction.y
		
	elif body.is_in_group("DeathBoundary"):
		emit_signal("ball_destroyed")
		queue_free()
	else:
		direction.y = -direction.y
	audio_player.play()
	

func _on_area_right_body_entered(body):
	if body.is_in_group("Blocks") && can_destroy:
		emit_signal("block_destroyed", body.score)
		speed += speed_increment
		body.queue_free()
		can_destroy = false
		cooldown_timer.start()
		direction.x = -direction.x
	elif !can_destroy:
		pass
	else:
		direction.x = -direction.x
	audio_player.play()



func _on_cooldown_timer_timeout():
	can_destroy = true
