extends StaticBody3D
@onready var particles = $"../CoinParticles"

func _physics_process(delta: float) -> void:
	#position.y+=delta/10
	var targetPos = PlayerGlobalManager.coins/210.0
	position.y=move_toward(position.y,targetPos,delta/20)
	position.y = clampf(position.y,0,4.484)
	if position.y < targetPos-0.05 and position.y<4.8:
		particles.emitting = true
	else:
		particles.emitting = false
	if position.y >=4.48:
		particles.emitting = false
