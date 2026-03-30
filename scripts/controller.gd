extends Node

@onready var fade_rect: ColorRect = %Blank

func _ready() -> void:
	fade_rect.modulate.a = 0.0
	get_tree().change_scene_to_file("res://scenes/cenarios/maloca.tscn")

func trocar_cena(caminho_da_cena: String):
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.5)
	
	await tween.finished
	
	get_tree().change_scene_to_file(caminho_da_cena)
	
	await get_tree().process_frame
	
	var tween_out = get_tree().create_tween()
	tween_out.tween_property(fade_rect, "modulate:a", 0.0, 0.5)
