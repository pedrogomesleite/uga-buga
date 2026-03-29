extends CharacterBody2D

const SPEED = 500.0
@export var forca_impacto: float = 20
var impulso_max: float = 200
var empurrao_velocity: Vector2 = Vector2.ZERO

var max_mouse_speed: float = 5000.0 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		#atrito
		velocity.x = lerp(velocity.x, 0.0, 15.0 * delta)
		
	move_and_slide()

func _on_pau_objeto_tocado(movimento_bloqueado: Vector2, delta: float) -> void:
	
	var mouse_vel = Input.get_last_mouse_velocity()
	var speed = mouse_vel.length()
	var mapped_strength = remap(speed, 0, max_mouse_speed, 0, 2)
	mapped_strength = clamp(mapped_strength, 0, 4)
	
	var vetor_impulso = -movimento_bloqueado * forca_impacto
	vetor_impulso = vetor_impulso.limit_length(impulso_max)
	velocity += (vetor_impulso * delta * forca_impacto) * mapped_strength
	velocity = velocity.limit_length(SPEED)
