return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "telescope",
    })
  end,
  keys = {
    { "<leader>nn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", desc = "Create new note" },
    {
      "<leader>ns",
      "<cmd>ZkNotes { sort = { 'modified' } }<cr>",
      desc = "Note picker",
    },
    { "<leader>nt", "<cmd>ZkTags<cr>", desc = "Filter notes by tags" },
    { "<leader>nm", mode = { "x" }, "<cmd>ZkMatch<cr>", desc = "Filter notes by current selection" },
    { "<leader>no", "<cmd>ZkLinks<cr>", desc = "Outbound links" },
    { "<leader>nb", "<cmd>ZkBackLinks<cr>", desc = "Backlinks" },
    { "<leader>nL", "<cmd>ZkInsertLink<cr>", desc = "Insert link" },
    { "<leader>nI", "<cmd>ZkIndex<cr>", desc = "Index notebook" },
    {
      "<leader>nT",
      mode = { "x" },
      "<cmd>ZkNewFromTitleSelection<cr>",
      desc = "Create new note from selection as title",
    },
    {
      "<leader>nC",
      mode = { "x" },
      "<cmd>ZkNewFromContentSelection<cr>",
      desc = "Create new note from selection as content",
    },
    { "<leader>nd", "<cmd>ZkCd<cr>", desc = "cd into the notebook root" },
  },
}
