module Jekyll
    Hooks.register :site, :pre_render do | site |
        if not (Gem.win_platform?)
            File.open("README.md", "w+") do | readme |
                readme.write "# Food Driven Development\n\n"
                readme.close()
            end
        end
    end
    Hooks.register :recipes, :post_render do | recipe |
        if not (Gem.win_platform?)
            File.open("README.md", "a") do | readme |
                readme.write "* [#{recipe['title']}](./_recipes/#{recipe.id}.md)\n"
                readme.close()
            end
        end
    end
end