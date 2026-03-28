extends CharacterBody2D

const SPEED = 300.0
@export var forca_impacto: float = 50.0  
@export var friccao_empurrao: float = 20.0 

var empurrao_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	empurrao_velocity = empurrao_velocity.lerp(Vector2.ZERO, friccao_empurrao * delta)
	
	velocity += empurrao_velocity
	move_and_slide()
	
	velocity.x = 0 

func _on_pau_objeto_tocado(corpo: Variant, direcao: Variant) -> void:
	var posicao_relativa = corpo.global_position - global_position
	
	var vel_mouse = remap(Input.get_last_mouse_velocity().length(), 0, 2000, 0, 2)
	var forca_final = forca_impacto
	print(-posicao_relativa.normalized(), -direcao, position)
	var vetor_impulso = posicao_relativa.normalized() * forca_final
	empurrao_velocity = vetor_impulso.limit_length(2000.0)
