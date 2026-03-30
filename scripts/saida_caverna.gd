extends Area2D

@export var next_scene = "res://scenes/cenarios/Floresta.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		Controller.trocar_cena(next_scene)
