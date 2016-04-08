module TableUtils
  def get_table_column_values(selector, column)
    column = column.strip

    within(selector) do
      table_columns = all('th').map { |table_column| table_column.text.strip }
      column_index = table_columns.index(column)
      expect(column_index).not_to be_nil

      all("tr > td:nth-child(#{column_index + 1})").each do |element|
        yield element.text.strip
      end
    end
  end
end
