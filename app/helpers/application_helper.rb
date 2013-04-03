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

	def index_process(f)
		f = strip_tags(f)
		f = f.gsub(/&nbsp;/i," ")
		f = truncate(f, :length => Random.rand(200..300))
		return f
	end
end
