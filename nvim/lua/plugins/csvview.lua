return {
  "hat0uma/csvview.nvim",
  ft = { "csv" },
  opts = {
    parser = {
      delimiter = {
        default = ";",
        ft = {
          tsv = "\t",
        }
      },
    },
    view = {
      display_mode = "border",
    },
  }
}

