class Order < ActiveRecord::Base
  private
  def order_params
    params.require(:order).permit(:addr, :billing, :city, :coupon, :district, :invoice_title, :mobile, :need_invoice, :nickname, :payment, :phone, :postal, :productid, :province, :quantity, :username, :created_at, :updated_at)
  end
end
