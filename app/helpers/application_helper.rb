module ApplicationHelper

	def can_edit (original, user)
		if original == user
			return true
		elsif user.admin?
			return true
		else
			return false
		end
	end

end
