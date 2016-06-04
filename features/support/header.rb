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
    # The call 'headers.each(&method(:set_header))' breaks on ruby 2.0.0-p598, which is the
    # default version on CentOS 7. When that SO updates ruby, this should be reverted to
    # the more concise syntax.
    headers.each { |key, value| set_header(key, value) }
  end
end
