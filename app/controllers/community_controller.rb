class CommunityController < ApplicationController

  helper :profile

  

  def index
  	@title = "Community"
  	@letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")
  	if params[:id]
  		@initial = params[:id]
  		specs = Spec.where("last_name LIKE ?", @initial+'%').order(:last_name, :first_name).paginate(page: params[:page], per_page: 10)
  		@users = specs.collect{ |spec| spec.user }

  		@pages = specs

  		#@pages, specs = paginate(:specs, :contidions => ["last_name LIKE ?", @initial +'%'], :order => "last_name, first_name")
  		#@pages = specs.paginate(page: params[:page], per_page: 10)
  	end
  end

  def browse
  end

  def search
	  	@title = "Search RailsSpace"
	  	if params[:q]
	  		query = params[:q]

	  		#First find the user hits...
	  		@users = User.find_with_ferret(params[:q])
	  		#....then the subhits.
	  		specs = Spec.find_with_ferret(query, :limit => 10)
			faqs = Faq.find_with_ferret(query, :limit => :all)


			# Now combine into one list of distinct users sorted by last name.
			hits = specs + faqs
			@users.concat(hits.collect{ |hit| hit.user }).uniq!

			# Sort by last name (requires a spec for each user).
			@users.each { |user| user.spec ||= Spec.new }
			@users = @users.sort_by { |user| user.spec.last_name }
	  end
   end


end