Rove.package :vim do
  category 'Tools'

  cookbook :vim
  recipe :vim

  option :vim_rails do
    title 'rails.vim'
    config do
      {
        vim: {
          extra_packages: %w[
            vim-rails
          ]
        }
      }
    end
  end
end
