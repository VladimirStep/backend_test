module RequestSpecHelpers
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  def json_headers
    {
      'ACCEPT' => 'application/json',
      'CONTENT_TYPE' => 'application/json'
    }
  end

  def get_ids(arrays_of_hashes)
    arrays_of_hashes.map { |item| item[:id] }
  end
end