class ReservationMapper
  def self.map(payload)
    begin
      parsed_payload = JSON.parse(payload)
    rescue JSON::ParserError => e
      raise "Invalid JSON format: #{e.message}"
    end

    parsed_payload.deep_symbolize_keys!

    puts "Parsed Payload: #{parsed_payload.inspect}"

    # Initialize the parsed data hash
    mapped_data = {}

    # Iterate through the schema to map values from the payload
    ReservationSchema::COMMON_SCHEMA.each do |key, paths|
      if paths.is_a?(Array)
        mapped_data[key] = find_in_payload(parsed_payload, paths)
      elsif paths.is_a?(Hash)
        mapped_data[key] = {}
        paths.each do |nested_key, nested_paths|
          mapped_data[key][nested_key] = find_in_payload(parsed_payload, nested_paths)
        end
      end
    end

    mapped_data
  end

  private

  def self.find_in_payload(payload, paths)
    paths.each do |path|
      value = dig_path(payload, path)
      return value if value.present?
    end
    nil
  end

  # This method traverses through a nested hash or array using a dot-separated path and returns the value at the given path.
  # If the value at the path is an array, it returns the first non-empty (truthy) element from that array.

  def self.dig_path(obj, path)
    # Step 1: Split the path into keys and convert each key to a symbol. 
    # If the key includes an array index (e.g., [0]), it's converted to an integer.
    keys = path.to_s.split('.').map { |key| key.match?(/\[\d+\]/) ? key.scan(/\d+/).first.to_i : key.to_sym }

    # Step 2: Traverse the object using the keys to dig into the hash or array. 
    # If a key is found in a hash or array, continue to the next key, otherwise return nil.
    result = keys.reduce(obj) { |acc, key| acc.is_a?(Hash) || acc.is_a?(Array) ? acc[key] : nil }

    # Step 3: If the result is an array, return the first truthy value (ignoring empty or nil values).
    # If not an array, return the result as is.
    return result.find(&:present?) if result.is_a?(Array)

    result
  end

end
