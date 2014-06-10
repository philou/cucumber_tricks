# -*- encoding: utf-8 -*-

# Extension to the Cucumber::Ast::Table class providing table transformation
# goodies
class Cucumber::Ast::Table

  # Similar to the #hashes method, but merges every hash into a default
  # hash of values. It can also create a hash from an untitled 1-column
  # table.
  #
  # * main_column : name of the given column in case of an untitled 1-column
  #   table
  # * defaults : the default values to merge into every hash
  def hashes_with_defaults(main_column, defaults = {})
    hashes_with_default_column(main_column).map do |hash|
      defaults.merge(hash)
    end
  end

  # Transforms the table into a collection of named lists. More precisely, this
  # is a hash from the value in the first column to a list of all the values
  # from the successive columns. Empty cells are simply ignored.
  # As a visual hint, the second column should only contain the '=>' marker.
  def hash_2_lists
    result = {}
    raw.each do |row|
      raise StandardError.new("hash_2_lists tables must have a '=>' in the second column") unless row.size == 1 or row[1] == '=>'

      result[row[0]] = row.drop(2).reject &:empty?
    end
    result
  end

  private

  def hashes_with_default_column(main_column)
    if column_names.size == 1
      raw.map do |row|
        { main_column => row.first }
      end
    else
      hashes
    end
  end

end


module KnowsCucumberTables
  def cucumber_table(single_value)
    Cucumber::Ast::Table.new([[single_value]])
  end
end

World(KnowsCucumberTables)
