class SiteGenerator

  def make_index!
    open('_site/index.html', 'a') { |file| file << "<!DOCTYPE html><html><head><title>Movies</title></head><body><ul>" }

    Movie.all.each do |movie|
      open('_site/index.html', 'a') do |file|
          file << "<li><a href=\"movies/#{movie.url}\">#{movie.title}</a></li>"
          #make sure you escape specific characters if you're using string interpolation INTO A STRING
        end
    end

    open('_site/index.html', 'a') do |file| file << "</ul></body></html>"
    end

  end

  def generate_pages!
    template = <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <title><%=movie.title%></title>
      </head>
      <body>
        <h1><%=movie.title%></h1>
          <h3>Release Date: <%=movie.release_date.to_i%></h3>
          <h4><em>Director: <%=movie.director%></em></h4>
          <p><%=movie.summary%></p>
          <br />
          <h2>Other Movies</h2>

        <ul>
          <% Movie.all.each do |movie| %>
            <li><a href="<%= movie.url%>"><%= movie.title %></a></li>
          <%  end %>
        </ul>
      </body>
    </html>
    HTML
    template2 = ERB.new(template)

    Movie.all.each do |movie|
        #result(binding) your environment is whats being inserted into this 
        File.open("_site/movies/#{movie.url}", "w+") { |f| f.write template2.result(binding)}
    end
  end

end
