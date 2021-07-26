for k, v in pairs(package.loaded) do
  if string.match(k, "^my") then
    print(k)
    package.loaded[k] = nil
  end
end

require('my-plugins')
require('my-nvim-tree')
require('my-telescope')
require('my-options')
require('my-keybinds')
