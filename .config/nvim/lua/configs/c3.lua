local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.c3 = {
  install_info = {
    url = 'https://github.com/c3lang/tree-sitter-c3', -- local path or git repo
    files = { 'src/parser.c', 'src/scanner.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = 'main',
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = 'c3', -- if filetype does not match the parser name
}
