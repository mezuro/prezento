include OwnershipAuthentication

class ReadingsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  # before_action :reading_group_owner?, except: [:show]

end
