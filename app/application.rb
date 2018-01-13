class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path =~ /items/
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path =~ /cart/
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |i|
          resp.write "#{i}\n"
        end
      end
    elsif req.path =~ /add/
      add_item = req.params["item"]
      if @@items.include?(add_item)
        @@cart << add_item
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end
    elsif req.path =~ /search/
      search_term = req.params["item"]
      resp.write handle_search(search_term)
    else
      resp.write 'Path Not Found'
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
