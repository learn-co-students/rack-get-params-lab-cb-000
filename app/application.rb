class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each {|item| resp.write "#{item}\n"}

    elsif req.path.match(/cart/)
      @@cart.empty? ? resp.write("Your cart is empty") : @@cart.each {|cart_item| resp.write "#{cart_item}\n"}

    elsif req.path.match(/add/)
      resp.write add_to_cart(req.params["item"])
  
    elsif req.path.match(/search/)
      resp.write handle_search(req.params["q"])
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end


  def add_to_cart(item)
    if @@items.include?(item)
      @@cart << item 
      "added #{item}"
    else
      "We don't have that item"
    end
  end

  def handle_search(search_term)
    @@items.include?(search_term) ? "#{search_term} is one of our items":
      "Couldn't find #{search_term}"
  end
end
