extends Area2D

# on spawn, pick a random direction and go
# whenever it collides with the boundaries, reverse velocity of one direction, keep velocity in other direction the same
# if colliding with the paddle, depending on which side of the paddle, change velocity accordingly

var direction: Vector2 = Vector2.ZERO
var initial_speed: int = 100
var speed: int = initial_speed

func _ready():
	await get_tree().create_timer(0.5).timeout
	
	direction = Vector2(randf_range(-1, 1), randf_range(0.1, 1)).normalized()

func _physics_process(delta):
	
	var velocity = direction * speed
	
	position += velocity * delta


func _on_body_entered(body):
	print(body)
