extends CharacterBody2D

@export var movement_speed = 50

@onready var sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var player = $"/root/World/Player"
@onready var label = $Label

var active = false # Whether enemy should be moving
var gravity = 1600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox.body_entered.connect(_on_body_entered)
	randomize_label()
	player.player_died.connect(_on_player_died)
	
# Generate a label for the enemy
func randomize_label():
	var random_texts = ["Enemy 1", "Enemy 2", "Boss", "Minion", "Danger!"]
	label.text = random_texts[randi() % random_texts.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

	
func _physics_process(delta: float) -> void:
	if not active:
		return
		
	velocity.x = -movement_speed
	velocity.y = gravity * delta
	move_and_slide()
	
func set_active(value):
	active = value
	if active:
		sprite.play("walk")

func _on_body_entered(body):
	if body.is_in_group("player") and active:
		player.die()

func _on_player_died():
	set_active(false)
	sprite.play("idle")
