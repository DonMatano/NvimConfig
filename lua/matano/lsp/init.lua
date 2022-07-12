local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "matano.lsp.lsp-installer"
require("matano.lsp.handlers").setup()
require "matano.nullls"
