extends Node2D


# Called when the node enters the scene tree for the first time.

var diff = position

func _ready() -> void:
	diff = position
	pass

@export var raio_maximo: float = 10.0
@export var velocidade_movimento: float = 6.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_relativo = get_local_mouse_position()
	
	# ir em direcao ao mouse
	var alvo_limitado : Vector2 = mouse_relativo.limit_length(raio_maximo)
	alvo_limitado += diff
	position = position.lerp(alvo_limitado, velocidade_movimento * delta)
