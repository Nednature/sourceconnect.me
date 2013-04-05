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

	def user_avatar_url(user, size)
		if user.avatar.present?
			if (size == 'thumb')
				user.avatar.url(:thumb)
			elsif (size == 'medium')
				user.avatar.url(:medium)
			elsif (size == 'small')
				user.avatar.url(:small)
			else
				user.avatar.url
			end
		else
			if (size == 'thumb')
				size2 = 64
			elsif (size == 'small')
				size2 = 100
			elsif (size == 'medium')
				size2 = 300
			else
				size2 = 80
			end
			gravatar_id = Digest::MD5::hexdigest(user.email).downcase
			"http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size2}&d=identicon"
		end
	end
end
