extends RigidBody2D

@export var timer: float = 5.0
var colide = true

func _ready() -> void:
	freeze = true
	collision_layer = 0  
	collision_mask = 0  

func _process(_delta: float) -> void:
	var colliding_bodies = get_colliding_bodies()
	if colliding_bodies.any(func(e): return e is CharacterBody2D):
		if colide: 
			colide = false
			var tween_out = get_tree().create_tween()
			tween_out.tween_property(self, "modulate:a", 0.0, timer)
			await tween_out.finished
			queue_free()

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if _body is CharacterBody2D:
		set_collision_layer_value(1, true)
		set_collision_layer_value(2, true)
		
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, true)
		
		set_deferred("freeze", false)
		set_deferred("sleeping", false)
