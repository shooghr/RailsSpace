class CommunityController < ApplicationController

  helper :profile

  before_action :inicia_ransack_browse, only:[:index, :browse]

  

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
    @title = "Browse"
    

    if params[:q]
      specs = @q.result(params[:q]).paginate(page: params[:page], per_page: 10)
      @users = specs.collect { |spec| spec.user }
      @pages = specs
    end
## sqlite> select birthdate, (strftime('%Y','now') - strftime('%Y',birthdate)) as idade  from specs 
##                  where (strftime('%Y','now') - strftime('%Y',birthdate)) < 35 and (strftime('%Y','now') - strftime('%Y',birthdate)) > 30;
  end

#  @Antiga Implementação do Método browse ('gem ferret' e 'gem acts_as_ferret' não funcionaram)
#
#  def browse
#    @title = "Browse"
#    return if params[:commit].nil?
#    specs = Spec.find_by_asl(params)
#    @users = specs.collect{ |spec| spec.user }
#
#    @pages = specs
#  end

  # @Nova Implementação do Método Search
  def search
  	@title = "Search RailSpace"
  	if params[:q]
  		@initial = params[:q]
  		specs = Spec.where("last_name LIKE ? or first_name LIKE ?", '%'+@initial+'%', '%'+@initial+'%').order(:last_name, :first_name).paginate(page: params[:page], per_page: 10)
  		@users = specs.collect { |spec| spec.user }

  		@pages = specs
  	end
  end

#  @Antiga Implementação do Método Search ('gem ferret' e 'gem acts_as_ferret' não funcionaram)
#
#  def search
#	  	@title = "Search RailsSpace"
#	  	if params[:q]
#	  		query = params[:q]
#
#	  		#First find the user hits...
#	  		@users = User.find_with_ferret(params[:q])
#	  		#....then the subhits.
#	  		specs = Spec.find_with_ferret(query, :limit => 10)
#			faqs = Faq.find_with_ferret(query, :limit => :all)
#
#
#			# Now combine into one list of distinct users sorted by last name.
#			hits = specs + faqs
#			@users.concat(hits.collect{ |hit| hit.user }).uniq!
#
#			# Sort by last name (requires a spec for each user).
#			@users.each { |user| user.spec ||= Spec.new }
#			@users = @users.sort_by { |user| user.spec.last_name }
#	  end
#  end

	private

	def improviment_search
	end

  def inicia_ransack_browse
      @q = Spec.ransack(params[:q])
  end

end