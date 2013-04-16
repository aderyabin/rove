Rove.package :vim do
  category 'Tools'

  option :vim_rails do
    title 'Vim Rails support'
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

  cookbook :vim
  recipe :vim
end
