class_name RaycastWorld
extends Node

var player:RaycastPlayer = RaycastPlayer.new()
var objects = []
var textures = []

var worldCanvas = [[0,1,0],[1,0,1],[0,1,0]]
var worldSize = [3,3]
var colorPallet = [[0,0,0,1],[1,0,0,1]]

func load(levelData):
	print(levelData)

func save() -> PackedByteArray:
	var worldString:PackedByteArray = "This is a world lvl file for AlexZavor's Raycast Game Engine
Thank you for viewing, for more info, check out the github repo:
https://github.com/AlexZavor/Raycaster\n".to_utf8_buffer()
	worldString.append(0)
	# World Data
	worldString.append_array("WLD".to_utf8_buffer())
	worldString.append(worldSize[0])
	worldString.append(worldSize[1])
	for y in worldCanvas:
		for x in y:
			worldString.append(x)
	worldString.append(colorPallet.size())
	for p in colorPallet:
		for x in p:
			worldString.append(x)
	worldString.append(0)
	# Player Data
	worldString.append_array("PLR".to_utf8_buffer())
	worldString.append((player.pos_x[0]/worldSize[0])*255)	# Float elimination, saved as unsigned byte 0-255 = 0-width
	worldString.append((player.pos_y[0]/worldSize[0])*255)
	for x in player.color:
		worldString.append(x)
	worldString.append(0)
	#Texture data
	#Obj Data
	return worldString
