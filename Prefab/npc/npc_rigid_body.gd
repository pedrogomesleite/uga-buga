extends RigidBody2D

@export var vida: int = 7
@export var tempo_fade: float = 5.0
@export var colide_from_start: bool = true

var colidindo: bool = true

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 10
	
	if not colide_from_start:
		stop_collision()

func stop_collision():
	freeze = true
	collision_layer = 0  
	collision_mask = 0  
	
func start_collision():
	set_collision_layer_value(1, true)
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	
	set_deferred("freeze", false)
	set_deferred("sleeping", false)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and colidindo:
		print("tomei")
		levar_hit()

func levar_hit():
	vida -= 1
	
	modulate = Color(1, 0, 0)
	
	var tween_hit = create_tween()
	tween_hit.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	
	if vida <= 0:
		morrer()

func morrer():
	colidindo = false
	
	var tween_fade = create_tween()
	
	tween_fade.tween_property(self, "modulate:a", 0.0, tempo_fade)
	
	tween_fade.finished.connect(queue_free)
