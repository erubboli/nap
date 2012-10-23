require 'net/http'
require 'json'
require 'nasreddin'

Day = Struct.new(:date, :name)

class Month
  def self.starting_on(day)
    days = JSON(Net::HTTP.get(URI(WEEKLY_BASE_URL + '/weekdays.json')))
    day_no = days.find { |dayhash| dayhash['day'].downcase == day.downcase }['id']
    new(day_no)
  end

  def initialize(starting_day_no)
    @starting_day = starting_day_no.to_i
  end

  def each
    (0..30).map do |i|
      day_no = ((@starting_day + i) % 7)
      day_no = 7 if day_no == 0
      name = JSON(Net::HTTP.get(URI("#{WEEKLY_BASE_URL}/weekdays/#{day_no}.json")))['day']
      Day.new(i + 1, name)
    end.each
  end
end

class RemoteMonth < Nasreddin::Resource('weekdays'); end
class QuickMonth
  def self.starting_on(day)
    days = RemoteMonth.all
    day_no = days.find { |d| d.day.downcase == day.downcase }
    new(day_no.id)
  end

  def initialize(starting_day_no)
    @starting_day = starting_day_no.to_i
  end

  def each
    (0..30).map do |i|
      day_no = ((@starting_day + i) % 7)
      day_no = 7 if day_no == 0
      name = RemoteMonth.find(day_no).day
      Day.new(i + 1, name)
    end.each
  end
end
