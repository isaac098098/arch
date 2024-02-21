call plug#begin()

Plug 'lervag/vimtex'

""Plug 'nvim-lualine/lualine.nvim'

""Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

""Plug 'nvim-tree/nvim-web-devicons'

""Plug 'nvim-lua/plenary.nvim'

""Plug 'nvim-lua/popup.nvim'

Plug 'arcticicestudio/nord-vim'

Plug 'SirVer/ultisnips'

call plug#end()

filetype plugin indent on
syntax enable

if has('termguicolors')
	set termguicolors
endif

colorscheme nord

lua << END

--satusline

--require('lualine').setup {
	--options = {
	    --icons_enabled = true,
	    --component_separators = { left = '', right = ''},
	    --section_separators = { left = '', right = ''},
	    --disabled_filetypes = {
          --statusline = {},
	      --winbar = {},
	      --'NvimTree',
	    --},
	    --ignore_focus = {},
	    --always_divide_middle = true,
	    --globalstatus = false,
	    --refresh = {
	      --statusline = 1000,
	      --tabline = 1000,
	      --winbar = 1000,
	    --}
	  --},
          --sections = {
	    --lualine_a = {'mode'},
	    --lualine_b = {'branch', 'diff', 'diagnostics'},
		--lualine_c = {{'filename',path=1}},
	    --lualine_x = {'encoding', 'fileformat', 'filetype'},
	    --lualine_y = {'progress'},
	    --lualine_z = {'location'}
	  --},
	  --inactive_sections = {
	    --lualine_a = {},
	    --lualine_b = {},
	    --lualine_c = {},
	    --lualine_x = {},
	    --lualine_y = {},
	    --lualine_z = {}
	  --},
	  --tabline = {},
	  --winbar = {},
	  --inactive_winbar = {},
	  --extensions = {}
--}

-- nvim-treesitter

--require'nvim-treesitter.configs'.setup {
  ---- A list of parser names, or "all" (the five listed parsers should always be installed)
  --ensure_installed = { "c", "lua", "vim", "vimdoc" },
--
  ---- Install parsers synchronously (only applied to `ensure_installed`)
  --sync_install = false,
--
  ---- Automatically install missing parsers when entering buffer
  ---- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  --auto_install = true,
--
  ---- List of parsers to ignore installing (or "all")
  ---- ignore_install = { "javascript" },
--
  ------ If you need to change the installation directory of the parsers (see -> Advanced Setup)
  ---- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
--
  --highlight = {
    --enable = true,
--
    ---- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    ---- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    ---- the name of the parser)
    ---- list of language that will be disabled
    ---- disable = { "c", "rust" },
    ---- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --disable = { },
    ---- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    ---- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    ---- Using this option may slow down your editor, and you may see some duplicate highlights.
    ---- Instead of true it can also be a list of languages
    --additional_vim_regex_highlighting = {"latex"},
  --},
--}

END

" ulti-snippets

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<a-tab>"
"let g:UltiSnipsJumpOrExpandTrigger = "<tab>"

nnoremap <leader>u <Cmd>call UltiSnips#RefreshSnippets()<CR>

inoremap <silent> ( <Cmd>call UltiSnips#Anon('($1)','','i','',1)<cr>
inoremap <silent> { <Cmd>call UltiSnips#Anon('{$1}','','i','',1)<cr>
inoremap <silent> [ <Cmd>call UltiSnips#Anon('[$1]','','i','',1)<cr>
inoremap <silent> " <Cmd>call UltiSnips#Anon('"$1"','','i','',1)<cr>
inoremap <silent> \| <Cmd>call UltiSnips#Anon("\\|$1\\|",'','i','',1)<cr>
"inoremap <silent> ' <Cmd>call UltiSnips#Anon("'$1'",'','i','',1)<cr>

inoremap kj <Esc>
map j gj
map k gk

augroup vimtex
	au!
	au User VimtexEventCompiling VimtexView
augroup END

" vim-snippets
"let g:UltiSnipsExpandTrigger       = '<Tab>'    " use Tab to expand snippets
"let g:UltiSnipsJumpForwardTrigger  = '<Tab>'    " use Tab to move forward through tabstops
"let g:UltiSnipsJumpBackwardTrigger = '<A-Tab>'  " use Shift-Tab to move backward through tabstops

" Preservar identación al ajustar las líneas

set breakindent
set formatoptions=l
set lbr

" line number and indentation

set nu
set numberwidth=1

" Tab size
set tabstop=4
set shiftwidth=4

" vimtex

let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_forward_search_on_start = 'false'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_automatic = 0

" Copiar todo el documento al clipboard
nmap <C-d> ggVG"+y

set guicursor=i:hor10
