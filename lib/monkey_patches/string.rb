module MonkeyPatches
  module String
    def to_bool
      # return false for "0" or "false", true for anything else
      return false if self.downcase == "false"
      return false if self == "0"
      true
    end
  end
end
