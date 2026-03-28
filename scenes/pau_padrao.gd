extends Node2D

signal objeto_tocado(corpo, direcao)

func _on_rigid_body_2d_objeto_tocado(corpo: Variant, direcao: Variant) -> void:
	objeto_tocado.emit(corpo, direcao)
