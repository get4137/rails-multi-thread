class Post < ApplicationRecord
  ARR = [
    Array(1..20_000_000),
    Array(20_000_001..40_000_000),
    Array(40_000_001..60_000_000),
    Array(60_000_001..80_000_000)
  ].freeze
end
