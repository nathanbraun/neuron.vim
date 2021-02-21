"           ╭─────────────────────neuron.vim──────────────────────╮
"           Maintainer:     ihsan, ihsanl[at]pm[dot]me            │
"           Description:    Take zettelkasten notes using neuron  │
"           Last Change:    2020 Jul 24 23:40:47 +03, @1595623251 │
"           First Appeared: 2020 May 24 16:20:56 +03, @1590326456 │
"           License:        MIT                                   │
"           ╰─────────────────────────────────────────────────────╯

if exists("g:_neuron_loaded")
	finish
endif
let g:_neuron_loaded = 1

let g:neuron_dir = get(g:, 'neuron_dir', fnamemodify(expand("%:p"), ":h")."/")

" fallback to using getcwd if the above gives us a relative path
if g:neuron_dir == './'
	let g:neuron_dir = getcwd() . "/"
endif

let g:neuron_backlinks_size = get(g:, 'neuron_backlinks_size', 40)
let g:neuron_backlinks_vsplit = get(g:, 'neuron_backlinks_vsplit', 1)
let g:neuron_backlinks_vsplit_right = get(g:, 'neuron_backlinks_vsplit_right', 1)
let g:neuron_debug_enable = get(g:, 'neuron_debug_enable', 0)
let g:neuron_executable = get(g:, 'neuron_executable', system('which neuron | tr -d "\n"'))
let g:neuron_fullscreen_search = get(g:, 'neuron_fullscreen_search', 0)
let g:neuron_fzf_options = get(g:, 'neuron_fzf_options', ['-d',':','--with-nth','2'])
let g:neuron_inline_backlinks = get(g:, 'neuron_inline_backlinks', 1)
let g:neuron_no_mappings = get(g:, 'neuron_no_mappings', 0)
let g:neuron_tags_name = get(g:, 'neuron_tags_name', 'tags')
let g:neuron_tags_style = get(g:, 'neuron_tags_style', 'multiline')
let g:neuron_tmp_filename = get(g:, 'neuron_tmp_filename', '/tmp/neuronzettelsbuffer')

nm <silent> <Plug>EditZettelNew :call neuron#edit_zettel_new()<cr>
nm <silent> <Plug>EditZettelSearchContent :call neuron#search_content(0)<cr>
nm <silent> <Plug>EditZettelSearchContentUnderCursor :call neuron#search_content(1)<cr>
nm <silent> <Plug>EditZettelNewFromCword :call neuron#edit_zettel_new_from_cword()<cr>
nm <silent> <Plug>EditZettelNewFromVisual :call neuron#edit_zettel_new_from_visual()<cr>
nm <silent> <Plug>EditZettelLast :call neuron#edit_zettel_last()<cr>
nm <silent> <Plug>NeuronRefreshCache :call neuron#refresh_cache(1)<cr>
nm <silent> <Plug>EditZettelSelect :call neuron#edit_zettel_select()<cr>
nm <silent> <Plug>EditZettelBacklink :call neuron#edit_zettel_backlink()<cr>
nm <silent> <Plug>EditZettelUnderCursor :call neuron#edit_zettel_under_cursor()<cr>
nm <silent> <Plug>InsertZettelLast :call neuron#insert_zettel_last(0)<cr>
nm <silent> <Plug>InsertZettelSelect :call neuron#insert_zettel_select(0)<cr>
nm <silent> <Plug>ToggleBacklinks :call neuron#toggle_backlinks()<cr>
nm <silent> <Plug>TagsAddNew :call neuron#tags_add_new()<cr>
nm <silent> <Plug>TagsAddSelect :call neuron#tags_add_select()<cr>
nm <silent> <Plug>TagsZettelSearch :call neuron#tags_search()<cr>

if !exists("g:neuron_no_mappings") || ! g:neuron_no_mappings
	nm gzn <Plug>EditZettelNew
	nm gzN <Plug>EditZettelNewFromCword
	vm gzN <esc><Plug>EditZettelNewFromVisual
	nm gzr <Plug>NeuronRefreshCache
	nm gzu <Plug>EditZettelLast
	nm gzU :call neuron#move_history(-1)<cr>
	nm gzP :call neuron#move_history(1)<cr>
	nm gzz <Plug>EditZettelSelect
	nm gzZ <Plug>EditZettelBacklink
	nm gzo <Plug>EditZettelUnderCursor
	nm gzs <Plug>EditZettelSearchContent
	nm gzS <Plug>EditZettelSearchContentUnderCursor
	nm gzl <Plug>InsertZettelLast
	nm gzi <Plug>InsertZettelSelect
	nm gzL :call neuron#insert_zettel_last(1)<cr>
	nm gzI :call neuron#insert_zettel_select(1)<cr>
	nm gzv <Plug>ToggleBacklinks
	nm gzt <Plug>TagsAddNew
	nm gzT <Plug>TagsAddSelect
	nm gzts <Plug>TagsZettelSearch
	ino <expr> <c-x><c-u> neuron#insert_zettel_complete(0)
	ino <expr> <c-x><c-y> neuron#insert_zettel_complete(1)
end

" refresh the cache now if we are in a zettelkasten dir
if filereadable(g:neuron_dir."neuron.dhall")
	let current_file = expand("%:p")
	if empty(current_file)
		call neuron#refresh_cache(0)
	else
		call neuron#refresh_cache(1)
	endif
endif

" : vim: set fdm=marker :
