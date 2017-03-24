function str_ends_with(str, ending)
  if str:len() < ending:len() then
    return false
  else
    return str:sub(str:len() - ending:len() + 1, str:len()) == ending
  end
end

function list_password_files(dir, files)
  ending = ".gpg"
  local iter_fn, dir_obj = hs.fs.dir(dir)
  while true do
    local file = iter_fn(dir_obj)
    if file == nil then break end
    if file:sub(1, 1) ~= "." then
      if hs.fs.attributes(dir .. "/" .. file)["mode"] == "directory" then
        list_password_files(dir .. "/" .. file, files)
      else
        if str_ends_with(file, ending) then
          table.insert(files, {file:sub(1, file:len() - ending:len()), dir})
        end
      end
    end
  end
  return files
end

function copy_password(r)
  if r ~= nil then
    output, status, type, rc = hs.execute("pass " .. r["text"] .. "/" .. r["subText"], true)
    if status then
      hs.pasteboard.setContents(output)
    end
  end
end

function choose_password()
  password_store_dir = "~/.password-store"
  local c = hs.chooser.new(copy_password)
  local files = {}
  list_password_files(password_store_dir, files)
  local choices = {}
  for i, entry in ipairs(files) do
    local file, dir = entry[1], entry[2]
    local dir_name = dir:sub(password_store_dir:len() + 2, dir:len())
    table.insert(choices, { ["text"] = dir_name, ["subText"] = file, ["uuid"] = file })
  end
  c:choices(choices)
  c:show()
end
