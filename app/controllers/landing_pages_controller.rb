class LandingPagesController < ApplicationController

def home
	@group = Group.all
end

def about
end

def faq
end

end
