class_name DiplodocusModel
extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_walk_animation() -> void:
    animation_player.play("walk")

func play_idle_animation() -> void:
    animation_player.play("idle")