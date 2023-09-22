extends Node2D

@onready var die_sound = $die
die_sound.stream = preload("res://die.wav")
die_sound.play()


