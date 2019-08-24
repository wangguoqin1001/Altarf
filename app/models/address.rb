class Address < ActiveRecord::Base
  belongs_to :membership

  private
  def address_params
    params.require(:address).permit(:addr, :city, :district, :membership_id, :mobile, :phone, :postal, :province, :username)
  end
end
