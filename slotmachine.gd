extends Control
@onready var slotTextures = ["res://Textures/slot1.png","res://Textures/slot2.png","res://Textures/slot3.png","res://Textures/slot4.png","res://Textures/slot5.png"]
var slotTexNums = [0,0,0]
@onready var slots = [$Slot1,$Slot2,$Slot3]
var currentSlotNum = 0

func _on_timer_timeout() -> void:
	slotTexNums[currentSlotNum] = (slotTexNums[currentSlotNum]+1)%slotTextures.size()
	slots[currentSlotNum].texture=load(slotTextures[slotTexNums[currentSlotNum]])

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("SlotStop"):
		currentSlotNum+=1
