extends Node3D
var spawnUI = load("res://Scenes/slotmachineui.tscn")
func _on_area_3d_body_entered(body: Node3D) -> void:
	get_parent().add_child(spawnUI.instantiate())
func _on_area_3d_body_exited(body: Node3D) -> void:
	$"../SlotMachineUI".queue_free()
