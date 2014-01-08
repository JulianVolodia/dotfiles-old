-- Document key bindings

local awful     = require("awful")
local table     = table
local ipairs    = ipairs
local pairs     = pairs
local math      = math
local string    = string
local type      = type
local modkey    = "Mod4"
local beautiful = require("beautiful")
local naughty   = require("naughty")
local capi      = {
   root = root,
   client = client
}

module("keydoc")

local doc = { }
local currentgroup = "Misc"
local orig = awful.key.new

-- Replacement for awful.key.new
local function new(mod, key, press, release, docstring)
   -- Usually, there is no use of release, let's just use it for doc
   -- if it's a string.
   if press and release and not docstring and type(release) == "string" then
      docstring = release
      release = nil
   end
   local k = orig(mod, key, press, release)
   -- Remember documentation for this key (we take the first one)
   local doc_exists = false
   for _, val in pairs(doc) do
      if val.help == docstring then
         doc_exists = true
         break
      end
   end
   if k and #k > 0 and docstring and (not doc_exists) then
      doc[k[1]] = { help = docstring,
            group = currentgroup }
   end

   return k
end
awful.key.new = new             -- monkey patch

-- Turn a key to a string
local function key2str(key)
   local sym = key.key or key.keysym
   local translate = {
      [" "] = "␣",
      ["Escape"] = "⎋",
      ["Return"] = "↵",
      ["Tab"] = "↹",
      ["Compose"] = "⎄",
      ["Delete"] = "⌦",
      ["Backspace"] = "⌫",
      ["XF86AudioMute"] = "🔈",
      -- For combined bindings
      ["#10"] = "#",
      ["j"] = "j/k",
      ["l"] = "l/h",
      ["UpArrow"] = "↑/↓",
      ["LeftArrow"] = "←/→",
      ["w"] = "w/e/r",
      ["PgUp"] = "⇞/⇟",
      ["Home"] = "↖/↘",
      ["XF86AudioLowerVolume"] = "🔉/🔊"
   }
   sym = translate[sym] or sym
   if not key.modifiers or #key.modifiers == 0 then return sym end
   local result = ""
   local translate = {
      [modkey] = "⌘",
      Shift    = "⇧",
      Control  = "⎈",
      Alt      = "⎇",
   }
   for _, mod in pairs(key.modifiers) do
      mod = translate[mod] or mod
      result = result .. mod .. " "
   end
   return result .. sym
end

-- Unicode "aware" length function (well, UTF8 aware)
-- See: http://lua-users.org/wiki/LuaUnicode
local function unilen(str)
   local _, count = string.gsub(str, "[^\128-\193]", "")
   return count
end

-- Start a new group
function group(name)
   currentgroup = name
   return {}
end

local function markup(keys)
   local result = {}

   -- Compute longest key combination
   local longest = 0
   for _, key in ipairs(keys) do
      if doc[key] then
     longest = math.max(longest, unilen(key2str(key)))
      end
   end

   local curgroup = nil
   for _, key in ipairs(keys) do
      if doc[key] then
     local help, group = doc[key].help, doc[key].group
     local skey = key2str(key)
     result[group] = (result[group] or "") ..
        string.format("%" .. (longest - unilen(skey)) .. "s", " ") ..
        skey .. "   <span color='" .. beautiful.fg_normal .. "'>" ..  help .. '</span>\n'
      end
   end

   return result
end

-- Display help in a naughty notification
local nid = nil
function display()
   local strings = awful.util.table.join(
      markup(capi.root.keys()),
      capi.client.focus and markup(capi.client.focus:keys()) or {})

   local result = ""
   for group, res in pairs(strings) do
      if #result > 0 then result = result .. "\n" end
      result = result .. '<span weight="bold">' ..group .. "</span>\n" .. res
   end
   nid = naughty.notify({ text = result,
              replaces_id = nid,
              hover_timeout = 0.1,
              timeout = 30 }).id
end
