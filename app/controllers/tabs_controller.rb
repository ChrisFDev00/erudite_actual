class TabsController < ApplicationController
  def index
    @units = Current.user.units

    # @units = Unit.includes(topics: :messages).where(id: unit_ids)

    @fake_messages = @units.map do |unit|
      Faker::Lorem.sentence(word_count: 10)
    end
  end

  def units
    @units  = Current.user.units
  end

  def messages
  end

  def timetable
  end
end
