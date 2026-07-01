return {
  "r4ppz/lspeek.nvim",
  opts = {
    window = {
      width = 70,
      height = 15,
      border = "single",
    },
    stack_limit = 7,
    select_first = false,
    keymaps = {
      close = "q",
      split = "s",
      vsplit = "v",
      enter = "<CR>",
    },
  },
  keys = {
    {
      "gD",
      function()
        require("lspeek").peek_definition()
      end,
      desc = "Peek Definition (lspeek)",
    },
    {
      "gT",
      function()
        require("lspeek").peek_type_definition()
      end,
      desc = "Peek Type Definition (lspeek)",
    },
  },
}
