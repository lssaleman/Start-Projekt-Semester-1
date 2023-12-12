extends Node2D

@onready var tut = get_node("AnimationPlayer")
@onready var tut2 = get_node("LeftArrowAni")
@onready var tut3 = get_node("RightArrowAni")
@onready var tut4 = get_node("EAni")
@onready var tut5 = get_node("RAni")
@onready var tut6 = get_node("DownArrowAni")
@onready var tut7 = get_node("AnimationPlayer7")

func _ready():
	tut.play("Spacebar")
	tut2.play("LeftArrow")
	tut3.play("RightArrow")
	#tut4.play("LeftArrow")
	#tut5.play("E")
	# tut6.play("R")
	tut7.play("DownArrow")
