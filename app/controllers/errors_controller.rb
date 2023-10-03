class ErrorsController < ApplicationController
    def notfound 
        render :status => 404
        # def error_404
        
        #   end

        #   def error_422
        #     render :status => 422, :formats => [:html], :layout => "white", :sub_layout => "left"
        #   end

        #   def error_500
        #     render :status => 500, :formats => [:html], :layout => "white", :sub_layout => "left"
        #   end

        #   def error_505
        #     render :status => 505, :formats => [:html], :layout => "white", :sub_layout => "left"
        #   end
    end
end
