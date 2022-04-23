module Utils
    def Utils.get_encoded_value(str)
        str.encode("iso-8859-1").force_encoding("utf-8")
    end
end