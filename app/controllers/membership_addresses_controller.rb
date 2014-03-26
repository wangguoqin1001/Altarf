class MembershipAddressesController < ApplicationController
  # GET /membership_addresses
  # GET /membership_addresses.json
  def index
    @membership_addresses = MembershipAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @membership_addresses }
    end
  end

  # GET /membership_addresses/1
  # GET /membership_addresses/1.json
  def show
    @membership_address = MembershipAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership_address }
    end
  end

  # GET /membership_addresses/new
  # GET /membership_addresses/new.json
  def new
    @membership_address = MembershipAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership_address }
    end
  end

  # GET /membership_addresses/1/edit
  def edit
    @membership_address = MembershipAddress.find(params[:id])
  end

  # POST /membership_addresses
  # POST /membership_addresses.json
  def create
    @membership_address = MembershipAddress.new(params[:membership_address])

    respond_to do |format|
      if @membership_address.save
        format.html { redirect_to @membership_address, notice: 'Membership address was successfully created.' }
        format.json { render json: @membership_address, status: :created, location: @membership_address }
      else
        format.html { render action: "new" }
        format.json { render json: @membership_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /membership_addresses/1
  # PUT /membership_addresses/1.json
  def update
    @membership_address = MembershipAddress.find(params[:id])

    respond_to do |format|
      if @membership_address.update_attributes(params[:membership_address])
        format.html { redirect_to @membership_address, notice: 'Membership address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /membership_addresses/1
  # DELETE /membership_addresses/1.json
  def destroy
    @membership_address = MembershipAddress.find(params[:id])
    @membership_address.destroy

    respond_to do |format|
      format.html { redirect_to membership_addresses_url }
      format.json { head :no_content }
    end
  end
end
