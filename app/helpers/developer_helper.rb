module DeveloperHelper
  def parse_array(array, attribute)
    array.each do |item|
      item[attribute] + ','
    end
  end
end
