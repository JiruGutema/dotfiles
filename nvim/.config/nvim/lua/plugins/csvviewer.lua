return {
  'hat0uma/csvview.nvim',
  opts = {
    parser = { async = true },
    view = { display_mode = "border" } -- uses vertical lines as borders
  },
  cmd = { "CsvViewEnable", "CsvViewToggle" },
}
