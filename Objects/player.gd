extends CharacterBody3D

@export var _moveSpeed = 20
@export var camera: Camera3D
@onready var camArm = $SpringArm3D
@export var _camSensitivity: float = 0.1
@export var _accel: float = 10
@onready var camPosCenter = $"../CameraPosCenter"
@onready var camPosPile = $"../CameraPosCoinPile"
@onready var playerModel = $PlayerModel
@onready var animator = $PlayerModel/AnimationPlayer
var camTargetNum = 1
var cameraPosTarget: Vector3 = Vector3.ZERO
var input_dir: Vector2 = Vector2.ZERO
var cam_input_dir
var dir_vel = 0.0

func _ready() -> void:
	cameraPosTarget = camPosCenter.global_position

func _physics_process(delta: float) -> void:
	var real_input_dir = Input.get_vector("left", "right", "up", "down", 0.5)
	if real_input_dir:
		input_dir = real_input_dir.rotated(-camera.global_rotation.y)
		dir_vel = move_toward(dir_vel,1,_accel*delta)
	else:
		dir_vel = move_toward(dir_vel,0,_accel*delta)
	if dir_vel>0.1:
		animator.play("Walk",0.2,dir_vel*3)
	else:
		animator.play("Idle",0.2)
	playerModel.rotation.y=lerp_angle(playerModel.rotation.y,PI/2-input_dir.angle(),delta*10)
	velocity.x=input_dir.x*_moveSpeed*dir_vel
	velocity.z=input_dir.y*_moveSpeed*dir_vel
	move_and_slide()
	updateCamera(delta)
	
#func _unhandled_input(event: InputEvent) -> void:

func updateCamera(delta: float):
	if camTargetNum == 1:
		cameraPosTarget = camPosCenter.global_position
	else:
		if camTargetNum == 2:
			cameraPosTarget = camPosPile.global_position
	camera.position = lerp(camera.position, cameraPosTarget, delta*5)
	
	camera.look_at(global_position,Vector3.UP)

func _on_coin_room_area_body_entered(body: Node3D) -> void:
	camTargetNum=2


func _on_main_room_area_body_entered(body: Node3D) -> void:
	camTargetNum=1
