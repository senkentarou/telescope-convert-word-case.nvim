local builtin = require('convert_word_case.builtin')

return require('telescope').register_extension {
  exports = {
    convert_word_case = builtin.convert_word_case,
  },
}
