extends Control
@onready var coinCount =$MarginContainer/CoinCount

func _physics_process(delta: float) -> void:
	coinCount.text = "Coins: "+str(PlayerGlobalManager.coins)
