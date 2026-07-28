-- In ~/.config/nvim/lua/plugins/cmp.lua (or similar)
return {
  {
    "hrsh7th/nvim-cmp",  -- or "saghen/blink.cmp" if you're on newer LazyVim
    opts = function(_, opts)
      opts.experimental = {
        ghost_text = false,
      }
      -- or for blink.cmp:
      -- opts.completion = {
      --   ghost_text = { enabled = false },
      -- }
    end,
  },
}
