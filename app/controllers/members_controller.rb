class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = Member.all
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def headers(url)

    doc = Nokogiri::HTML(RestClient.get(url))
    header_tags = (1..3).map { |num| "h#{num}" }
    headers = []
    @member.headings = doc.css(*header_tags).map do |node|
        headers << node.name
        node.text
    end
  end

  def create
    @member = Member.new(member_params)
    client = Bitly::API::Client.new(token: "796016fee064d7b96f06223589e913d28815c4e1")
    bitlink = client.shorten(long_url: "https://" + @member.website)
    @member.short = bitlink.link
    headers(@member.short)
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_member
      @member = Member.find(params[:id])
    end

    def member_params
      params.require(:member).permit(:name, :website)
    end
end