local previewers = require('telescope.previewers')

local P = {}

P.previewer = function(opts)
  opts = opts or {}
  return previewers.new_buffer_previewer({
    title = 'case preview',
    define_preview = function(self, entry, _)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
        opts.current_word .. '  ' .. entry.opts.converted_word,
      })
    end,
  })
end

return P
