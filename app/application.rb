class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
    #searching for item
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      #if cart empty..
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
      #if theres something in your cart..
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
    #if you have this #item, add it to #cart
      if @@items.include? item_to_add
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
    #if not in #items then..
      else
        resp.write "We don't have that item!"
      end
    #else, error..
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end



  def handle_search(search_term)
  #do you guys have this item?
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
  #item not found
      return "Couldn't find #{search_term}"
    end
  end
end
