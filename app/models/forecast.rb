class Forecast
  include ActiveModel::Model 
  include ActiveModel::Attributes

  attribute :battery_capacity, :decimal, default: 50.00
  attribute :battery_level_at_the_beginning, :integer, default: 20
  attribute :battery_level_at_the_end, :integer, default: 80
  attribute :power_output, :decimal, default: 3.65
  attribute :elapsed, :time, default: '8:00:00'
  attribute :power_output_calculated, :decimal
  attribute :elapsed_calculated, :time

  validates :battery_capacity, presence: true
  validates :battery_level_at_the_beginning, presence: true
  validates :battery_level_at_the_end, presence: true
  validates :power_output, presence: true
  validates :elapsed, presence: true

  def calculate_fields
      energy_required = ((battery_level_at_the_end * battery_capacity) / 100) - ((battery_level_at_the_beginning * battery_capacity) / 100) 
      elapsed_decimal = elapsed.to_time.hour + elapsed.to_time.min / 60.00
      self.power_output_calculated = energy_required / elapsed_decimal
      elapsed_decimal_calculated = (energy_required / power_output).round(2)
      hours_elapsed = elapsed_decimal_calculated.to_i
      minutes_elapsed = (elapsed_decimal_calculated - hours_elapsed ) / 0.6
      self.elapsed_calculated = [hours_elapsed, minutes_elapsed, 0].join(':')
  end

end
