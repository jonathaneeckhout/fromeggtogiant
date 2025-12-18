class_name Trex
extends CharacterBody2D

@export var wander_speed: float = 50.0
@export var wander_range: float = 200.0
@export var idle_time: float = 2.0

@onready var model: TrexModel = $TrexModel

var wander_target: Vector2
var is_wandering: bool = false
var idle_timer: float = 0.0

var original_scale: Vector2

func _ready():
    original_scale = model.scale
    _set_new_wander_target()

func _physics_process(delta):
    if idle_timer > 0:
        idle_timer -= delta
        velocity = Vector2.ZERO
    elif is_wandering:
        var direction = (wander_target - global_position).normalized()
        velocity = direction * wander_speed
        
        if global_position.distance_to(wander_target) < 10.0:
            is_wandering = false
            idle_timer = idle_time
            _set_new_wander_target()
    
    if velocity.x != 0:
        model.scale.x = - sign(velocity.x) * original_scale.x

    if velocity != Vector2.ZERO:
        model.play_walk_animation()
    else:
        model.play_idle_animation()

    move_and_slide()

func _set_new_wander_target():
    var random_offset = Vector2(
        randf_range(-wander_range, wander_range),
        randf_range(-wander_range, wander_range)
    )
    wander_target = global_position + random_offset
    is_wandering = true