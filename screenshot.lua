function getLatestScreenshot()
	local latestScreenshot = ""
	local earliestTimestamp = 0
    local homeDir = os.getenv("HOME") .. "/Desktop"
	for file in hs.fs.dir(homeDir) do
        local creationTimestamp = hs.fs.attributes( homeDir .. file, "creation")
        if (earliestTimestamp == 0 and string.match(file, "Screen Shot")) then
            earliestTimestamp = creationTimestamp
            latestScreenshot = file
        end

        if ((creationTimestamp > earliestTimestamp) 
            and string.match(file, "Screen Shot")) then

            earliestTimestamp = creationTimestamp
            latestScreenshot = file
        end
    end

	return os.getenv("HOME") .. "/Desktop/" .. latestScreenshot
end

function copyLatestScreenshotToClipboard()
    local latest = getLatestScreenshot()
    local asReadFile = "(read (POSIX file \"" .. latest .. "\") as JPEG picture)"
    local appleScriptFragment = "set the clipboard to " .. asReadFile
    local success, outputObject, result = hs.osascript.applescript(appleScriptFragment)
    hs.alert.show("Last screenshot copied.")
end






hs.hotkey.bind(hyper, "4", function()
  local fileName = os.getenv("HOME") .. "/Desktop/ss-" .. getTimeStamp() .. ".png"
  hs.task.new("/usr/sbin/screencapture", nil, {"-i", fileName }):start()
  hs.pasteboard.setContents(fileName)
  
  image = hs.image.imageFromPath(fileName)
  hs.pasteboard.writeObjects(image)
end)

hs.window.focusedWindow():snapshot()

