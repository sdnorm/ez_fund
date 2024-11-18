# module ActionDispatch::Routing
#   class Mapper
#     def authenticated(resource, &block)
#       constraint = ->(request) {
#         user_id = request.session[:user_id]
#         user_id.present? && User.exists?(user_id)
#       }

#       constraints(constraint, &block)
#     end
#   end
# end
