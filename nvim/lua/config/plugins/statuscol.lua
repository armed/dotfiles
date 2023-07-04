return {
  event = "CursorHold",
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    local statuscol = require("statuscol")
    statuscol.setup({
      relculright = true,
      segments = {
        {
          sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        {
          sign = {
            name = { ".*" },
            maxwidth = 2,
            colwidth = 1,
            auto = false,
            wrap = true,
          },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
