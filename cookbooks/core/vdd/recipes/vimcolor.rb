bash "modify_color_vim" do
  not_if do
    File.exists?("/usr/share/vim/vim73/colors/nucolors.vim")
  end
  user "root"
  cwd "/usr/share/vim/vim73/colors/"
  code <<-EOH
    git clone https://github.com/ryu-blacknd/vim-nucolors.git
    mv /usr/share/vim/vim73/colors/vim-nucolors/colors/nucolors.vim /usr/share/vim/vim73/colors/nucolors.vim
    rm -rf vim-nucolors	
    echo "colorscheme nucolors
set number
augroup module 
autocmd BufRead,BufNewFile *.module set filetype=php
autocmd BufRead,BufNewFile *.php set filetype=php
autocmd BufRead,BufNewFile *.install set filetype=php 
autocmd BufRead,BufNewFile *.test set filetype=php
autocmd BufRead,BufNewFile *.inc set filetype=php
autocmd BufRead,BufNewFile *.profile set filetype=php
autocmd BufRead,BufNewFile *.theme set filetype=php 
augroup END
set cursorline" >> /usr/share/vim/vimrc
  EOH
end
