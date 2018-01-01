class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      resp.write "Your cart is empty" if @@cart.empty?
      if !@@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    end
    if req.path.match(/add/)
      add_item = req.params['item']
      #resp.write "#{add_item}"
      search_result = handle_search(add_item)
      if search_result
        @@cart << add_item
        resp.write "added #{add_item}"
      else
        resp.write "We don't have that item"
      end
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return true
    else
      return false
    end
  end
end
