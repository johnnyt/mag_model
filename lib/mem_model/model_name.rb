module MemModel
  class ModelName < String
    def human; self; end
    def singular; self; end
    def plural; self; end
  end
end
