function set_default_volume(args)
  local node_om = ObjectManager {
    Interest {
      type = "node",
      args["node"]
    }
  }

  local function _set_volume()
    for node in node_om:iterate() do
      local channels = tonumber(node.properties["ChannelCount"]) or 2
      local volume = {}
      for i = 1, channels do
        volume[i] = args["volume"]
      end
      node:set_volume(volume)
      print("Set volume to " .. args["volume"] .. " for node " .. (node.properties["node.name"] or "unknown"))
    end
  end

  node_om:connect("object-added", _set_volume)
  node_om:activate()
end
