extends Node2D


func finalizar():
	var twene = get_tree().create_tween()
	twene.tween_property(self, "modulate:a", 0.0, 15)
	await twene.finished
	Controller.finalizar_game()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		finalizar()
