require 'the_matrix/version'
require 'the_matrix/utilities/common'
require 'the_matrix/utilities/csv'
require 'the_matrix/utilities/json'
require 'the_matrix/parser'
require 'the_matrix/path'
require 'the_matrix/route'
# Main Module
module TheMatrix
  def self.root
    File.dirname __dir__
  end

  def self.data_path
    File.join root, 'data'
  end
end
