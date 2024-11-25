-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
  lspconfig.nixd.setup {
      cmd = { "nixd" },
      settings = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
        formatting = {
          command = { "alejandra" },
        },
        options = {
          nixos  = {
            expr = '(builtins.getFlake "/home/user/nixos-config/flake.nix)".nixosConfigurations.system.options',
          },
          home_manager = {
            expr = '(builtins.getFlake "/home/user/nixos-config/flake.nix)".nixosConfigurations.system.options',
          },
        },
      },
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
