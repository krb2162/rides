class Driver < ApplicationRecord
    has_many :rides

    validates_presence_of :home_address
    #TODO: add address validation
end