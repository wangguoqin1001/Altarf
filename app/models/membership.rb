class Membership < ActiveRecord::Base
  has_many :addresses

  private
  def membership_params
    params.require(:membership).permit(:addr, :city, :district, :email, :gender, :mobile, :nickname, :phone, :postal, :province, :username, :created_at, :updated_at)
  end
end
