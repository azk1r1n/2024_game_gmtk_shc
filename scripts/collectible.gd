extends Area2D

@export var value = 10

@onready var game = $'/root/World'
@onready var sprite = $AnimatedSprite2D
@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	randomize_label()
	
# Generate a label for the enemy
func randomize_label():
	var random_texts = ["+1", "+2", "x2", "+10", "x100", "-30"]
	label.text = random_texts[randi() % random_texts.size()]

func _on_body_entered(body):
	if body.is_in_group("player"):
		game.add_score(value)
		sprite.play("collected")
		sprite.animation_finished.connect(_on_animation_finished)
		
func _on_animation_finished():
	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
