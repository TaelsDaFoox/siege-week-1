extends Control
@onready var slotTextures = ["res://Textures/slot1.png","res://Textures/slot2.png","res://Textures/slot3.png","res://Textures/slot4.png","res://Textures/slot5.png"]
var slotTexNums = [0,2,4]
@onready var slots = [$Slot1,$Slot2,$Slot3]
var currentSlotNum = 0
@onready var resultText=$MarginContainer/ResultText
@export var payouts := [0,25,50,100,200]
@export var payoutNames := ["SORRY NOTHING","Not bad!","It's you!","Coins Galore!!","- J A C K P O T -"]


func _on_timer_timeout() -> void:
	slotUpdate(true)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("SlotStop"):
		if currentSlotNum==0:
			PlayerGlobalManager.coins-=10
		slotCheat()
		currentSlotNum+=1
		if currentSlotNum == slots.size():
			slotScore()

func slotUpdate(increase: bool):
	for i in range(currentSlotNum,slots.size()):
		if increase:
			slotTexNums[i] = (slotTexNums[i]+1)%slotTextures.size()
		slots[i].texture=load(slotTextures[slotTexNums[i]])

func slotCheat():
	#slotTexNums[currentSlotNum]=randi()%5
	if currentSlotNum > 0 and currentSlotNum<3:
		if randi() % 3 == 0: 
			slotTexNums[currentSlotNum]=slotTexNums[0]
			slotUpdate(false)

func slotScore():
	if slotTexNums[0]==slotTexNums[1] and slotTexNums[1]==slotTexNums[2]:
		PlayerGlobalManager.coins+=payouts[slotTexNums[0]]
		resultText.text=payoutNames[slotTexNums[0]]
	else:
		resultText.text="Try again!"
	
