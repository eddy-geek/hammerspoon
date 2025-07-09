-- =============================================================================
-- App-Specific Window Cycler
-- =============================================================================

-- =============================================================================
-- App-Specific Window Cycler (v2 - with stable cycling and logging)
-- =============================================================================

-- Use hs.logger to print debug messages to the Hammerspoon Console
hs.logger.setGlobalLogLevel("verbose")
local log = hs.logger.new("WindowCycler")
log.setLogLevel("verbose") -- Set to "info" to see less, or "verbose" to see all

-- Define the core function to cycle through an application's windows
local function cycleAppWindows(appName)
  log.v("----- Starting Cycle for: " .. appName .. " -----")

  local app = hs.application.get(appName)
  if not app then
    log.w("Application '" .. appName .. "' is not running.")
    return
  end

  -- Get all "standard" windows (ones you can normally tab to) and filter out minimized ones
  local allAppWindows = app:allWindows()
  local appWindows = hs.fnutils.filter(allAppWindows, function(w)
    return w:isStandard() and not w:isMinimized()
  end)

  -- Sort windows by their ID to ensure a consistent cycling order every time
  table.sort(appWindows, function(a, b) return a:id() < b:id() end)

  if #appWindows == 0 then
    log.w("No valid, non-minimized windows found for " .. appName)
    app:activate() -- Still try to activate the app itself
    return
  end
  
  log.v("Found " .. #appWindows .. " windows for " .. appName)

  local frontmostApp = hs.application.frontmostApplication()
  local focusedWindow = hs.window.focusedWindow()

  log.v(frontmostApp " is frontmost and " .. focusedWindow .. " window has focus")

  -- Condition to cycle: App is already in front and has more than one window
  if frontmostApp and frontmostApp:name() == appName and #appWindows > 1 then
    log.v("App is frontmost. Proceeding to cycle.")
    
    if not focusedWindow then
        log.w("App is frontmost, but no window is focused. Focusing the first one.")
        appWindows[1]:focus()
        return
    end

    local currentWindowID = focusedWindow:id()
    local currentIndex = nil

    -- Find the index of the current window by matching its ID
    for i, win in ipairs(appWindows) do
      log.v("  - Checking window #" .. i .. " (ID: " .. win:id() .. ", Title: " .. win:title() .. ")")
      if win:id() == currentWindowID then
        currentIndex = i
        log.info("Found focused window at index: " .. currentIndex .. " (ID: " .. currentWindowID .. ")")
        break
      end
    end

    if currentIndex then
      -- Calculate the next window's index, wrapping around from the end to the start
      local nextIndex = (currentIndex % #appWindows) + 1
      log.info("Calculated next window index: " .. nextIndex)
      
      -- Focus the next window
      appWindows[nextIndex]:focus()
    else
      -- This can happen if a non-standard window was focused (e.g., a "Save" dialog)
      log.w("Could not find the focused window in the list. Focusing first window as a fallback.")
      appWindows[1]:focus()
    end

  else
    -- Condition to activate: App is not in front, or has only one window.
    log.v("App is not frontmost or has only one window. Activating app and focusing first window.")
    app:activate() -- This brings the whole app forward
    -- A small delay can help ensure the window is ready to be focused after the app activates
    hs.timer.doAfter(0.1, function()
        appWindows[1]:focus()
    end)
  end
end

-- =============================================================================
-- Define Your Hotkeys
-- =============================================================================

-- Clear previous bindings to avoid duplicates on reload

hs.hotkey.deleteAll({"ctrl"}, "e")
hs.hotkey.bind({"ctrl"}, "e", function() cycleAppWindows("Finder") end)
hs.hotkey.deleteAll({"ctrl"}, "g")
hs.hotkey.bind({"ctrl"}, "g", function() cycleAppWindows("Google Chrome") end)
hs.hotkey.deleteAll({"ctrl"}, "h")
hs.hotkey.bind({"ctrl"}, "h", function() cycleAppWindows("Safari") end)
hs.hotkey.deleteAll({"ctrl"}, "f")
hs.hotkey.bind({"ctrl"}, "f", function() cycleAppWindows("Firefox") end)
hs.hotkey.deleteAll({"ctrl"}, "c")
hs.hotkey.bind({"ctrl"}, "c", function() cycleAppWindows("Microsoft Teams") end)
hs.hotkey.deleteAll({"ctrl"}, "m")
hs.hotkey.bind({"ctrl"}, "m", function() cycleAppWindows("Microsoft Outlook") end)
hs.hotkey.deleteAll({"ctrl"}, "z")
hs.hotkey.bind({"ctrl"}, "z", function() cycleAppWindows("Terminal") end)
hs.hotkey.deleteAll({"ctrl"}, "s")
hs.hotkey.bind({"ctrl"}, "s", function() cycleAppWindows("System Settings") end)

-- Show a confirmation that the config has been loaded
hs.alert.show("Hammerspoon config reloaded")
