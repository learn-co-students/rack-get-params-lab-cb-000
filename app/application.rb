class Application
  @@items = %w[Apples Carrots Pears]
  @@cart  = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path =~ /items/
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path =~ /search/
      search_term = req.params['q']
      resp.write handle_search(search_term)

    elsif req.path =~ /cart/
      resp.write 'Your cart is empty' if @@cart.empty?
      @@cart.each { |item| resp.write "#{item}\n" }

    elsif req.path =~ /add/
      add_item = req.params['item']
      resp.write handle_add(add_item)

    else
      resp.write 'Path Not Found'
    end

    resp.finish
  end

  def handle_add(item)
    if @@items.include?(item)
      @@cart << item
      "Successfully added #{item}"
    else
      "We don't have that item"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
