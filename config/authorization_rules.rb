# authorization do

#   role :guest do
#     has_permission_on :pages, :to => :read
#   end

#   role :manager do
#     includes :assessor
#     has_permission_on :organizations, :to => :manage
#   end

#   role :assessor do
#     includes :guest
#     has_permission_on [:reports, :structures], :to => :manager
#   end
# end

# privileges do
#   privilege :manage do
#     includes :create, :read, :update, :delete
#   end

#   privilege :read, :includes => [ :index, :show ]
#   privilege :create, :includes => [:new]
#   privilege :update, :includes => :edit
#   privilege :delete, :includes => :destroy
# end
