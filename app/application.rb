class Application

  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        resp.write "YOUR CART CONTENTS ARE:\n\n"
        @@cart.each{|item| resp.write "#{item}\n"}
      end
    elsif req.path.match(/add/)
      requested_item = req.params["item"]
      if @@items.include?(requested_item)
        @@cart << requested_item
        resp.write "added #{requested_item}\n"
      else
        resp.write "We don't have that item\nITEM NOT ADDED\n"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items\n"
    else
      return "Couldn't find #{search_term}\n"
    end
  end
end
