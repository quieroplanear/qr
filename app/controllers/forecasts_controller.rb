class ForecastsController < ApplicationController
      def show
      end
    
      def new
        @forecast = Forecast.new
      end
    
      def create
        @forecast = Forecast.new(recharge_params)
    
        if @forecast.calculate_fields
          render :show
        else
          render :new, status: :unprocessable_entity
        end
    
      end
     
      private
        def recharge_params
          params.require(:forecast).permit(:battery_capacity, :battery_level_at_the_beginning, :battery_level_at_the_end, :power_output, :elapsed)
        end
    
    end
