local commands = {
  python = function(filepath) return "python3 "..filepath end,
  javascript = function(filepath) return "node "..filepath end,
  html = function(filepath) return "open "..filepath end,

  rust = function(filepath)
    local filename = string.match(filepath, "[^/]+$"):sub(1,-4) -- main
    local filedir = filepath:sub(1, filepath:match(".+()/")) -- /Users/agoni/Documents/CompSci/test/check/src/
    local dir_to_src = filedir:match("(.-)/src")
    if dir_to_src then
      local handle = io.popen("(cd "..dir_to_src.." && ls)") -- /Users/agoni/Documents/CompSci/test/check
      local is_cargo = string.find(handle:read("*a"), "Cargo.toml")
      handle:close()

      if is_cargo then
        return "(cd "..filedir.." && cargo run)"
      end
    end

    return "(cd "..filedir.." && rustc "..filepath.." && ./"..filename..")"
  end,

  lua = function(filepath) return "lua "..filepath end,
  java = function(filepath)
    local filename = string.match(filepath, "[^/]+$"):sub(1,-6)
    local filedir = filepath:sub(1, filepath:match(".+()/"))
    return "(cd "..filedir.." && javac "..filepath.." && java "..filename..")"
  end,
  svelte = function(filepath)
    local filedir = filepath:sub(1, filepath:match(".+()/"))
    return "(cd "..filedir.." && npm run dev)"
  end,
}

return commands
