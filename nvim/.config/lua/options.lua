local options = {
	modifiable = true, -- allow buffer modification
	backup = false, -- creates a backup file

	hlsearch = false, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns

	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore

	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	swapfile = false, -- creates a swapfile

	-- termguicolors = true, -- set term gui colors (most terminals support this)
	-- timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = false, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	linebreak = true, -- companion to wrap, don't split words
	scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
	sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
	-- guifont = "monospace:h17", -- the font used in graphical neovim applications
	whichwrap = "bs<>[]hl", -- which "horizontal" keys are allowed to travel to prev/next line
	breakat = [[\ \	;:,!?]], -- these characters are valid break points for words
	breakindent = true, -- start wrapped lines indented
	breakindentopt = "shift:2,min:20", -- set to autoindent if breakindent is set
	fillchars = { horiz = "─", vert = "│" }, -- change the characters used to fill vertical and horizontal lines

}

for k, v in pairs(options) do
	vim.opt[k] = v
end
