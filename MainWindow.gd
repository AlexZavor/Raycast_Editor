extends Node

var menuFloat = [0.5]
var menuChecked = true

func ShowExampleMenuFile():
	ImGui.MenuItemEx("(demo menu)", "", false, false)
	ImGui.MenuItem("New")
	ImGui.MenuItemEx("Open", "Ctrl+O")
	if (ImGui.BeginMenu("Open Recent")):
		ImGui.MenuItem("fish_hat.c")
		ImGui.MenuItem("fish_hat.inl")
		ImGui.MenuItem("fish_hat.h")
		if (ImGui.BeginMenu("More..")):
			ImGui.MenuItem("Hello")
			ImGui.MenuItem("Sailor")
			if (ImGui.BeginMenu("Recurse..")):
				ShowExampleMenuFile()
				ImGui.EndMenu()
			ImGui.EndMenu()
		ImGui.EndMenu()
	ImGui.MenuItemEx("Save", "Ctrl+S")
	ImGui.MenuItem("Save As..")

	ImGui.Separator()
	if (ImGui.BeginMenu("Options")):
		var enabled = true
		#ImGui.MenuItem("Enabled", "", &enabled)
		ImGui.BeginChild("child", Vector2(0, 60))
		for i in 10:
			ImGui.Text("Scrolling Text %d" % i)
		ImGui.EndChild()
		var n = 0
		ImGui.SliderFloat("Value", menuFloat, 0.0, 1.0)
		ImGui.InputFloatEx("Input", menuFloat, 0.1)
		#ImGui.Combo("Combo", n, "Yes\nNo\nMaybe\n\n")
		ImGui.EndMenu()

	if (ImGui.BeginMenu("Colors")):
		var sz = ImGui.GetTextLineHeight()
		for i in 10:
			#var name = ImGui.GetStyleColorName((ImGuiCol)[i])
			var p = ImGui.GetCursorScreenPos()
			#ImGui.GetWindowDrawList()->AddRectFilled(p, ImVec2(p.x + sz, p.y + sz), ImGui.GetColorU32((ImGuiCol)i))
			ImGui.Dummy(Vector2(sz, sz))
			ImGui.SameLine()
			ImGui.MenuItem(name)
		ImGui.EndMenu()

	#// Here we demonstrate appending again to the "Options" menu (which we already created above)
	#// Of course in this demo it is a little bit silly that this function calls BeginMenu("Options") twice.
	#// In a real code-base using it would make senses to use this feature from very different code locations.
	if (ImGui.BeginMenu("Options")):
		var b = [true]
		ImGui.Checkbox("SomeOption", b)
		ImGui.EndMenu()

	#if (ImGui.BeginMenuEx("Disabled", false)):
		#IM_ASSERT(0)
	ImGui.MenuItemEx("Checked", "", menuChecked)
	ImGui.Separator()
	ImGui.MenuItemEx("Quit", "Alt+F4")


func _ready():
	Engine.max_fps = 60
	var io := ImGui.GetIO()

func _process(_delta: float) -> void:
	ImGui.ShowDemoWindow()
	
	if (ImGui.BeginMainMenuBar()):
		if (ImGui.BeginMenu("File")):
			ShowExampleMenuFile()
			ImGui.EndMenu()
		if (ImGui.BeginMenu("Edit")):
			ImGui.MenuItem("Undo")
			ImGui.MenuItem("Redo") # Disabled item
			ImGui.Separator()
			ImGui.MenuItem("Cut")
			ImGui.MenuItem("Copy")
			ImGui.MenuItem("Paste")
			ImGui.EndMenu()
		ImGui.EndMainMenuBar()
