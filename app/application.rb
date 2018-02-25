class Application

  @@items = ["Apples","Carrots","Pears"]

  # Create a new class array called @@cart to hold any items in your cart
  @@cart = []

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

    # Create a new route called /cart to show the items in your cart
    elsif req.path.match(/cart/)
      # responds with empty cart message if the cart is empty
      if @@cart.empty?
        resp.write "Your cart is empty"
      # responds with a cart list if there is something in there
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    # Create a new route called /add that takes in a GET param with the key item
    # This should check to see if that item is in @@items and then add it to the cart if it is. Otherwise give an error.
    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      # check to see if that item is in @@items
      if @@items.include? item_to_add
        # add an item that IS in the @@items list
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        # do NOT add an item that is NOT in the @@items list
        resp.write "We don't have that item!"
      end
    else
      resp.write "Path Not Found"
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
