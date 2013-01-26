module PeriodsHelper
  def special_period_labels_for(period)
    labels = ""

    labels << "<span class=label>planning</span>" if @convention.periods(:planning).include?(period)
    labels << "<span class=label>production</span>" if @convention.periods(:production).include?(period)
    labels << "<span class=label>open</span>" if @convention.periods(:open).include?(period)
    labels << "<span class=label>wrap-up</span>" if @convention.periods(:wrap_up).include?(period)

    labels.html_safe
  end
end
