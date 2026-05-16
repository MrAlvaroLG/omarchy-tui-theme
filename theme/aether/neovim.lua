return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg         = "#141515",
        dark_bg    = "#0f1010",
        darker_bg  = "#0a0b0b",
        lighter_bg = "#2c2c2c",

        fg         = "#cbc2be",
        dark_fg    = "#98928f",
        light_fg   = "#d3cbc8",
        bright_fg  = "#d8d1ce",
        muted      = "#4b4e55",

        red        = "#565d60",
        yellow     = "#d9dbdc",
        orange     = "#6f7578",
        green      = "#9fa5a9",
        cyan       = "#707070",
        blue       = "#798186",
        purple     = "#aeaeae",
        brown      = "#434648",

        bright_red    = "#978e8c",
        bright_yellow = "#c9c2b4",
        bright_green  = "#343d41",
        bright_cyan   = "#707070",
        bright_blue   = "#5d6367",
        bright_purple = "#9a9a9a",

        accent               = "#798186",
        cursor               = "#cbc2be",
        foreground           = "#cbc2be",
        background           = "#141515",
        selection             = "#2c2c2c",
        selection_foreground = "#cbc2be",
        selection_background = "#2c2c2c",
      },
    },
    -- set up hot reload
    config = function(_, opts)
      require("aether").setup(opts)
      vim.cmd.colorscheme("aether")
      require("aether.hotreload").setup()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
