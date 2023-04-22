require "json"

module Jekyll
  Hooks.register :site, :pre_render do | site |
    if not (Gem.win_platform?)
      Dir.glob("./_recipes/*.json") do | jsonfilename |
        begin
          File.open("./_recipes/#{File.basename(jsonfilename, '.json')}.md", "w") do | markdown |
            json = JSON.load_file(jsonfilename) 
            title = json['name'].strip
            yields = json['recipeYield'].strip
            totaltime = "#{Integer(Time.parse(json['totalTime'].strip).strftime('%I'))} tim #{Time.parse(json['totalTime'].strip).strftime('%M')} min"
            description = json['description'].strip
            instructions = json['recipeInstructions'].strip
            url = json['url'].strip
            ingredients = json['recipeIngredient'].select { | ingredient | ingredient.strip }

            markdown.puts "---"
            markdown.puts "title: #{title}"
            markdown.puts "---"
            markdown.puts "# #{title}"
            markdown.puts
            markdown.puts description
            markdown.puts 
            markdown.puts "| #{'Antal portioner'.ljust(['Antal portioner'.length, yields.length].max, ' ')} | #{'Total tid'.ljust(['Total tid'.length, totaltime.length].max, ' ')} |"
            markdown.puts "| #{''.ljust(['Antal portioner'.length, yields.length].max, '-')} | #{''.ljust(['Total tid'.length, totaltime.length].max, '-')} |"
            markdown.puts "| #{yields.ljust(['Antal portioner'.length, yields.length].max, ' ')} | #{totaltime.ljust(['Total tid'.length, totaltime.length].max, ' ')} |"
            markdown.puts
            markdown.puts "## Ingredienser"
            ingredients.each do | ingredient |
              markdown.puts "* #{ingredient}"
            end
            markdown.puts
            markdown.puts "# Tillagning"
            markdown.puts instructions
            if url
              markdown.puts
              markdown.puts "Recept från [#{url}](#{url})."
            end 
            markdown.close()
          end
        rescue
          print "Error parsing #{jsonfilename}"
        end
      end
    end  
  end  
end