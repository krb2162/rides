class Driver < ApplicationRecord
    has_many :rides

    validates_presence_of :home_address
    #TODO: address validation with an address gem
end