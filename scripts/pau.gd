extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


@export var velocidade_rotacao: float = 2
@export var raio_maximo: float = 100.0
@export var velocidade_movimento: float = 4.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_relativo = get_parent().get_local_mouse_position()
	
	# ir em direcao ao mouse
	var alvo_limitado = mouse_relativo.limit_length(raio_maximo)
	position = position.lerp(alvo_limitado, velocidade_movimento * delta)
	
	# girar em direcao ao mouse
	var angulo_alvo = mouse_relativo.angle()
	rotation = lerp_angle(rotation, angulo_alvo + PI/2, velocidade_rotacao * delta)
	
func _on_body_entered(body: Node) -> void:
	# 1. Pegamos a posição global do que tocamos
	var posicao_tocado = body.global_position
	
	# 2. Calculamos a direção (Vetor que aponta para o alvo)
	var direcao = (posicao_tocado - global_position).normalized()
	
	print("Toquei em algo na direção: ", direcao)
	
	# Exemplo: Se quiser saber se está à direita ou esquerda
	if direcao.x > 0:
		print("O objeto está à minha direita")
	else:
		print("O objeto está à minha esquerda")
