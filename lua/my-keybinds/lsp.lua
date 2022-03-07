local map = vim.keymap.set

local opts = { noremap=true, silent=true }
map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end



-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--
local lsp_installer = require "nvim-lsp-installer"
local servers = { 'sumneko_lua', 'bashls', 'tsserver', 'omnisharp' }
--local servers = { 'bashls', 'tsserver' }


-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
print(capabilities)
local use_lua_dev = true


for _, lsp in pairs(servers) do
    ---LSP INSTALL SERVER
    local server_is_found, server = lsp_installer.get_server(lsp)
    if server_is_found and not server:is_installed() then
        print("Installing " .. lsp)
        server:install()
    end

    ---LSP CONFIG
    if lsp == 'sumneko_lua' and use_lua_dev then
        --require('lspconfig')[lsp].setup { on_attach = on_attach } -- withoute lua-dev for nvim completion
        require('lspconfig')[lsp].setup(require('lua-dev').setup {
            library = {
                vimruntime = true,
                types = true,
                plugins = false,
            },

            lspconfig = {
                settings = {
                    Lua = {
                        telemetry = {
                            enable = false,
                        },
                        workspace = {
                            preloadFileSize = 180
                        }
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities -- TODO: is this a thing?
            }
        })
    elseif lsp == 'omnisharp' then
        local pid = vim.fn.getpid()
        require('lspconfig')[lsp].setup {
            cmd = { "OmniSharp", "--languageserver" , "--hostPID", tostring(pid) };
            on_attach = on_attach,
            capabilities = capabilities -- TODO: is this a thing?
        }
    else
        require('lspconfig')[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities -- TODO: is this a thing?
        }
    end
end
