local status_ok, luadev = pcall(require, "lua-dev")

local system_name = ""
if vim.fn.has "mac" then
  system_name = "macOs"
elseif vim.fn.has "unix" then
  system_name = "Linux"
elseif vim.fn.has "win32" then
  system_name = "Windows"
else
  vim.notify "Unsupported system for sumneko"
end

local sumneko_root_path = vim.fn.stdpath "data" .. "/lsp_servers/sumneko_lua/extension/server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

if not status_ok then 
return {
	settings = {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    flags = { debounce_text_changes = 150 },
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
}
end

return luadev.setup{
  lspconfig = {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    flags = { debounce_text_changes = 150 },

  }
}
