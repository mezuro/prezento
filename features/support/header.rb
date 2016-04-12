module HeaderUtils
  def set_header(key, value)
    header_method = nil
    if defined?(page) && ! page.driver.nil?
      header_method = [:add_header, :header].find(&page.driver.method(:respond_to?))
    end

    raise StandardError.new("No header setting method available in current driver: #{page.driver}") unless header_method
    page.driver.send(header_method, key, value)
  end

  def set_headers(headers)
    headers.each(&method(:set_header))
  end
end
