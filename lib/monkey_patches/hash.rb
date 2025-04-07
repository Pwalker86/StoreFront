module MonkeyPatches
  module Hash
    def deep_find(key)
      each do |k, v|
        return v if k == key
        if v.is_a?(::Hash)
          result = v.deep_find(key)
          return result if result
        end
      end
      nil
    end
  end
end
