class CalendarsController < ApplicationController
  def index

    @week_days = getWeek

    @plan = Plan.new
  end

  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']


    @todays_date = Date.today


    week_days = []

    plans = Plan.where(date: @today_date..@today_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @today_date + x
      end

      day_info = {
        :month => (@todays_date + x).month,
        :date => (@todays_date + x).day,
        :day_of_week => wdays[(@todays_date + x).wday], # 曜日の情報を追加
        :plans => today_plans
      }
      week_days.push(day_info)

    end

    week_days
  end
end
