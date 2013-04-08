module ApplicationHelper

	def can_edit (original, user)
		if original == user
			return true
		elsif user.try(:admin)
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

	def user_slug(user)
		slug = User.find(user.id).slug
		slug
	end

	def user_path(user)
		slug = user_slug(user)
		path = "/users/#{slug}"
	end

	def comment_editor_path(post,comment)
		url = "/posts/#{post.slug}/comments/#{comment.id}/edit"
		url
	end

	def comment_rm_path(post,comment)
		url = "/posts/#{post.slug}/comments/#{comment.id}/"
		url
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

	def FILES3
		Dir.glob(/home/daniel/src/public/users/avatars/**/*).each do |path|
			attachment = File.open path
			next if File.directory? attachment

			full_path = File.expand_path attachment
			id = full_path.match(/(\d+)\/original\/.+$/)[1]
			puts "Re-Saving ##{id}..."
			your_model = User.avatar.find(id)
			your_model.document = attachment
		end
	end

end
