require('oil').setup({
  default_file_explorer = true,
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  delete_to_trash = false,
  skip_confirm_for_simple_edits = true,
  prompt_save_on_select_new_entry = true,
  cleanup_delay_ms = false,
  constrain_cursor = "editable",
  watch_for_changes = true,
  use_default_keymaps = true,
})
