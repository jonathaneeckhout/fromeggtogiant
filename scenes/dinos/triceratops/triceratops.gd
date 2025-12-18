extends CharacterBody2D

@export var speed: float = 150.0

@onready var model: TriceratopsModel = $TriceratopsModel

var original_scale: Vector2

func _ready():
    original_scale = model.scale

func _physics_process(_delta: float) -> void:
    var direction = Vector2.ZERO

    if Input.is_action_pressed("ui_right"):
        direction.x += 1
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1
    if Input.is_action_pressed("ui_down"):
        direction.y += 1
    if Input.is_action_pressed("ui_up"):
        direction.y -= 1

    direction = direction.normalized()
    velocity = direction * speed

    if velocity.x != 0:
        model.scale.x = - sign(velocity.x) * original_scale.x

    if velocity != Vector2.ZERO:
        model.play_walk_animation()
    else:
        model.play_idle_animation()

    move_and_slide()
