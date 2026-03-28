extends CharacterBody2D


signal objeto_tocado(vel_martelo, normal)

@export var velocidade_rotacao: float = 20.0
@export var raio_maximo: float = 360.0
@export var velocidade_movimento: float = 5.0
@export var distancia_ponta: float = 160.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var mouse_relativo = get_parent().get_local_mouse_position()
	# girar em direcao ao mouse
	var angulo_alvo = mouse_relativo.angle()
	rotation = lerp_angle(rotation, angulo_alvo + PI/2, velocidade_rotacao * delta)
	
	var alvo_limitado = mouse_relativo.limit_length(raio_maximo)
	var alvo_centro = alvo_limitado
	
	var offset_ponta = Vector2(0, -distancia_ponta).rotated(rotation)
	alvo_centro = alvo_limitado - offset_ponta
	
	# ir em direcao ao mouse
	var direcao = alvo_centro - position
	print(direcao, alvo_centro, position)
	var velocidade_adicional = direcao * velocidade_movimento
	#print(position)
	
	
	checar_colisoes(velocidade_adicional, delta)

func checar_colisoes(velocidade: Vector2, delta: float):
	var colisao = move_and_collide(velocidade * delta)
	if colisao:
		var normal = colisao.get_normal()
		var movimento_bloqueado = colisao.get_remainder()
		objeto_tocado.emit(movimento_bloqueado, delta)
