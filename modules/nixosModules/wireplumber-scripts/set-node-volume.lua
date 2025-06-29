function set_node_volume(args)
  local node_om = ObjectManager {
    Interest {
      type = "node",
      Constraint { args["subject"], "matches", args["object"] }
    }
  }

  local function _set_volume()
    for node in node_om:iterate() do
      -- i have no clue how to set the volume of the node here
    end
  end

  node_om:connect("object-added", _set_volume)
  node_om:activate()
end
