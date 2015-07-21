class Avatar < ActiveRecord::Base

# Image sizes
	IMG_SIZE = '"240x300"'
	THUMB_SIZE = '"50x64"'

# Image directories
	URL_STUB = "/images/avatars"
	DIRECTORY = File.join("public","images","avatars")

	def initialize(user, image = nil)
		@user = user
		@image = image
		Dir.mkdir(DIRECTORY) unless File.directory?(DIRECTORY)
	end 

	# Save the avatar images.
	def save
		valid_file? and sucessful_conversion?
	end

	def exists?
		File.exists? (File.join(DIRECTORY, filename))
	end

	alias exist? exists?

	def avatar_url
		"#{URL_STUB}/#{filename}"
	end

	def thumbnail_url
		"#{URL_STUB}/#{thumbnail_url}"
	end

	def delete
		[filename, thumbnail_name].each do |name|
			image = "#{DIRECTORY}/#{name}"
			File.delete(image) if File.exists?(image)
		end
	end

	private

	# Return the filename of the main avatar.
	def filename
		"#{@user.screen_name}.png"
	end

	# Return the file name of the avatar thumbnail
	def thumbnail_name
		"#{@user.screen_name}_thumbnail.png"
	end

	def convert
		if ENV["OS"] =~ /Windows/
			# Set this to point to the right Windows directory for ImageMagick.
			"C:\\Program Files\\ImageMagick-6.3.1-Q16\\convert"
		else
			"/usr/bin/convert"
		end
	end

	# Try to resize image file and convert to PNG
	# We use ImageMagick's convert command to ensure sensibel image sizes.
	def sucessful_conversion?
		# Prepare the filenames for the conversion.
		source = File.join("tmp", "#{@user.screen_name}_full_size")
		full_size = File.join(DIRECTORY, filename)
		thumbnail = File.join(DIRECTORY, thumbnail_name)

		# Ensure that small and large images both work by writing to a normal file.
		# (Small files show up as StringIO, larger ones as Tempfiles.)
		File.open(source, "wb") { |f| f.write(@image.read) }

		# Convert the files.
		img = system("#{convert} #{source} -resize #{IMG_SIZE} #{full_size}")
		thumb = system("#{convert} #{source} -resize #{THUMB_SIZE} #{thumbnail}")
		File.delete(source) if File.exists?(source)

		# Both conversions must succeed, else it's an error.
		unless img and thumb
			errors.add_to_base("File upload failed. Try a different image?")
			return false
		end

		# No error-checking yet!
		return true
	end

	# Return treu for a valid, nonempty image file.
	def valid_file?
		# The upload should be nonempty.
		if @image.size.zero?
			errors.add_to_base("Please enter an image filename")
			return false
		end

		unless
			errors.add(:image, "is not a recognized format")
			return false
		end

		if @image.size > 1.megabyte
			errors.add(:image, "Can't bigger than 1 megabyte")
			return false
		end

		return true
	end

end
