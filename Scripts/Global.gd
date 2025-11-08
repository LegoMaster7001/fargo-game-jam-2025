extends Node2D

signal role_changed(hunted: bool)

var hunted = false

# "alias" for !hunted
var hunting: bool :
	get(): return !hunted
