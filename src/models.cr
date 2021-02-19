module Models
  struct Point
    property lat : String
    property lng : String

    def initialize(@lat, @lng)
    end
  end
end
