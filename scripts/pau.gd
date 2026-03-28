extends CharacterBody2D


signal objeto_tocado(vel_martelo, normal)

@export var velocidade_rotacao: float = 20.0
@export var raio_maximo: float = 100.0
@export var velocidade_movimento: float = 15.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var mouse_relativo = get_parent().get_local_mouse_position()
	# ir em direcao ao mouse
	
	var alvo_limitado = mouse_relativo.limit_length(raio_maximo)
	var direcao = alvo_limitado - position
	var velocidade_adicional = direcao * velocidade_movimento
	
	# girar em direcao ao mouse
	var angulo_alvo = mouse_relativo.angle()
	rotation = lerp_angle(rotation, angulo_alvo + PI/2, velocidade_rotacao * delta)
	
	checar_colisoes(velocidade_adicional, delta)

func checar_colisoes(velocidade: Vector2, delta: float):
	var colisao = move_and_collide(velocidade * delta)
	if colisao:
		var normal = colisao.get_normal()
		objeto_tocado.emit(velocidade, normal)
