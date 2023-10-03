class Admin::AdminController < ApplicationController
	layout 'admin'
	before_action :require_admin

	private

	def require_admin
		if current_user.nil?
			render :text => 'Ja da mag nie!'
		else
			unless current_user.has_role? :admin
				render :text => 'Ja da mag nie!'
			end
		end
	end
end