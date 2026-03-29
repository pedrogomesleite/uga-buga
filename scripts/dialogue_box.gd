extends MarginContainer

signal enviar_texto(frase: String)

func _ready() -> void:
	hide()

func on_texto_recebido(frase: String) -> void:
	show()
	enviar_texto.emit(frase)
