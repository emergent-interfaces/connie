class RulesController < ApplicationController
  def destroy
    rule_class = params[:rule_type].constantize
    rule = rule_class.find(params[:rule_id])
    @event = rule.event
    rule.destroy
    redirect_to @event
  end
end