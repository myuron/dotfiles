return {
  "folke/flash.nvim",
  dependencies = "levnas/cmigemo.nvim",
  keys = {
    {
      "s",
      function()
        require("cmigemo.ext.flash").jump()
      end,
      mode = { "n", "x", "o" },
      desc = "Flash: Migemo Jump"
    },
    {
      "r",
      function()
        require("cmigemo.ext.flash").remote()
      end,
      mode = "o",
      desc = "Flash: Migemo Remote"
    }
  }
}
