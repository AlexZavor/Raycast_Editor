extends Node

static var file = ""
static var levelData = ""

static func save(world:RaycastWorld):
	print("Saving file")
	if(file.is_empty()):
		print("No file")
	else:
		levelData = world.save()
		FileAccess.open(file, FileAccess.WRITE).store_buffer(levelData)

static func load():
	print("Loading file - %s" %file)
	if(file.is_empty()):
		print("No file Selected")
	else:
		if(FileAccess.file_exists(file)):
			levelData = FileAccess.open(file, FileAccess.READ).get_as_text()
