class_name LevelEditor

var worldTab = WorldEditorTab.new()

func drawLevelEditor():
		if (ImGui.BeginTabBar("##Tabs", ImGui.TabBarFlags_TabListPopupButton | ImGui.TabBarFlags_FittingPolicyScroll)):
			if (ImGui.BeginTabItem("World")):
				worldTab.drawWorldEditorTab()
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Player")):
				ImGui.Text("ID: 0123456789")
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Texture 1")):
				ImGui.Text("Wow look, it's a texture")
				ImGui.EndTabItem()
			if (ImGui.BeginTabItem("Object: \"flower\"")):
				ImGui.Text("pretty flower")
				ImGui.EndTabItem()
			ImGui.EndTabBar()
