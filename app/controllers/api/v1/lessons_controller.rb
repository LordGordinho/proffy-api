class Api::V1::LessonsController < ApplicationController
  def create
    lesson = Lesson.new(lesson_params.merge(schedules_attributes: format_schedule_attributes) )
    p lesson_params.merge(schedules_attributes: format_schedule_attributes)

    if lesson.save
      render json: { lesson: lesson}, code: 201
    else
      render json: { errors: lesson.errors}, code: 403
    end
  end

  def index
    lessons = Oj.load(Lesson.includes(:user).joins(:user).select("lessons.*, users.name, users.avatar, users.whatsapp").to_json)

    render json: { lessons: lessons }, code: 200
  end

  private 

  def lesson_params
    params.permit(:subject, :cost, :user_id)
  end

  def schedule_attributes
    params.permit(schedule_attributes: [ :week_day, :from, :to ])
  end

  def format_schedule_attributes
    schedule_attributes['schedule_attributes'].map do |schedule_attribute|
      {
        week_day: schedule_attribute['week_day'],
        from: convert_hour_to_minutes(schedule_attribute['from']),
        to: convert_hour_to_minutes(schedule_attribute['to'])
      }
    end
  end

  def convert_hour_to_minutes(time)
    hour, minutes = time.split(':').map(&:to_i)
    time_in_minutes = (hour * 60) + minutes
  
    time_in_minutes
  end
end
