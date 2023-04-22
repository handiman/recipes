module Jekyll
    Hooks.register :site, :pre_render do | site |
        if not (Gem.win_platform?)
            File.open("README.md", "w+") do | readme |
                readme.puts "# Food Driven Development\n"
                readme.close()
            end
        end
    end
    Hooks.register :recipes, :post_render do | recipe |
        if not (Gem.win_platform?)
            File.open("README.md", "a") do | readme |
                readme.puts "* [#{recipe['title']}](./_recipes/#{recipe.id}.md)"
                readme.close()
            end
        end
    end
end