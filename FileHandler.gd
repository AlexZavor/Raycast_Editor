extends Node

static var file = ""
static var levelData = ""

static func save():
	print("Saving file")
	if(file.is_empty()):
		print("No file")
	else:
		FileAccess.open(file, FileAccess.WRITE).store_string(levelData)

static func load():
	print("Loading file - %s" %file)
	if(file.is_empty()):
		print("No file Selected")
	else:
		if(FileAccess.file_exists(file)):
			levelData = FileAccess.open(file, FileAccess.READ).get_as_text()
