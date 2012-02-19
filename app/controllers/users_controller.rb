class UsersController < InheritedResources::Base
  respond_to :html, :json

  actions :show
end
