extends CharacterBody2D


var health :=3 #Enemy starts with the 3 hit points 

func take_damage(amount: int = 1) -> void:
	health -= amount
	print("Enemy Hit, health left is :", health)
	
	if health <=0:
		die()
		
func die() -> void:
	print("Oh no I am dead")
	queue_free()
		
