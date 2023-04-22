require "json"

module Jekyll
  Hooks.register :site, :pre_render do |site|
    File.open("README.md", "w+") do |readme|
      readme.puts "# Food Driven Development\n"
      readme.close()
    end

    Dir.glob("./_recipes/*.json") do |jsonfilename|
      begin
        File.open("./_recipes/#{File.basename(jsonfilename, ".json")}.md", "w") do |markdown|
          json = JSON.parse(File.read(jsonfilename))
          @step = ""
          markdown.puts "---"
          markdown.puts "title: #{(json["name"] || "Namnlös").strip}"
          markdown.puts "---"
          markdown.puts "# #{(json["name"] || "Namnlös").strip}"
          markdown.puts

          if json["description"]
            @step = "Render description"
            markdown.puts json["description"].strip
            markdown.puts
          end

          if json["recipeYield"] && json["totalTime"]
            @step = "Render yield"
            yields = "#{json["recipeYield"]}".strip
            begin
              totaltime = "#{Integer(Time.parse("#{json["totalTime"]}".strip).strftime("%I"))} tim #{Time.parse(json["totalTime"].strip).strftime("%M")} min"
            rescue
              totaltime = json["totalTime"]
            end
            markdown.puts "| #{"Antal portioner".ljust(["Antal portioner".length, yields.length].max, " ")} | #{"Total tid".ljust(["Total tid".length, totaltime.length].max, " ")} |"
            markdown.puts "| #{"".ljust(["Antal portioner".length, yields.length].max, "-")} | #{"".ljust(["Total tid".length, totaltime.length].max, "-")} |"
            markdown.puts "| #{yields.ljust(["Antal portioner".length, yields.length].max, " ")} | #{totaltime.ljust(["Total tid".length, totaltime.length].max, " ")} |"
            markdown.puts
          end

          if json["recipeIngredient"]
            @step = "Render ingredients"
            markdown.puts "## Ingredienser"
            json["recipeIngredient"].select { |ingredient| "#{ingredient}".strip }.each do |ingredient|
              markdown.puts "* #{ingredient}"
            end
            markdown.puts
          end

          if json["recipeInstructions"]
            @step = "Render instructions"
            markdown.puts "# Tillagning"
            if json["recipeInstructions"].kind_of?(Array)
              json["recipeInstructions"].each do |instruction|
                if instruction["@type"] == "HowToStep"
                  markdown.puts instruction["text"].strip
                else
                  markdown.puts instruction.strip
                end
              end
            else
              markdown.puts json["recipeInstructions"].strip
            end
            markdown.puts
          end

          if json["url"]
            @step = "Render URL"
            url = json["url"].strip
            markdown.puts
            markdown.puts "Recept från [#{url}](#{url})."
          end
          markdown.close()

          File.open("README.md", "a") do |readme|
            readme.puts "* [#{json["name"]}](./_recipes/#{File.basename(jsonfilename, ".json")}.md)"
            readme.close()
          end
        end
      rescue => e
        puts "---#{File.basename(jsonfilename, ".json")}---"
        print "#{e.class} at '#{@step}' in #{jsonfilename}\n#{e.message}"
      end
    end
  end
end
