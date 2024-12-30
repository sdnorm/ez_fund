class DeviseBaseController < ApplicationController
  def policy_scope(scope)
    super([ :devise, scope ])
  end

  def authorize(record, query = nil)
    super([ :devise, record ], query)
  end

  def skip_authorization
    true
  end

  def skip_policy_scope
    true
  end
end
