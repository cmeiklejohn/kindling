class ItemsController < InheritedResources::Base
  respond_to :html, :json

  actions :index, :show

  def begin_of_association_chain
    current_user
  end
  protected :begin_of_association_chain
end
