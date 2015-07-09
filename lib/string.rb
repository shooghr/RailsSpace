class String

	# Return an alternate string if blak

	def or_else(alternate)
		blank? ? alternate : self
	end
end