module Spree
  module OrderExport
    module ReportsControllerExt
      def self.included(base)
        base.class_eval do

          def order_export
            export = !params[:q].nil?
            params[:q] = {} unless params[:q]

            if params[:q][:created_at_gt].blank?
              params[:q][:created_at_gt] = Time.zone.now.beginning_of_month
            else
              params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
            end

            if params[:q] && !params[:q][:created_at_lt].blank?
              params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
            end

            params[:q][:completed_at_not_null] ||= "1"
            if params[:q].delete(:completed_at_not_null) == "1"
              params[:q][:completed_at_not_null] = true
            end

            params[:q][:meta_sort] ||= "created_at.desc"

            @search = Spree::Order.ransack(params[:q])

            render and return unless export

            @orders = @search.result


            orders_export = CSV.generate(:col_sep => ",", :row_sep => "\r\n") do |csv|
              headers = [
                t('order_export_ext.header.last_updated'),
                t('order_export_ext.header.completed_at'),
                t('order_export_ext.header.number'),
                "Ordered By",
                "Company",
                "Name",
                "Address1",
                "Address2",
                "City",
                "State",
                "Zip",
                "Phone",
                "Country",
                t('order_export_ext.header.variant_name'),
                "Options",
                # t('order_export_ext.header.nonprofit'),
                # t('order_export_ext.header.discount'),
                t('order_export_ext.header.quantity'),
                t('order_export_ext.header.order_total'),
                t('order_export_ext.header.payment_method'),
                "Service Type",
                "Weight"
              ]

              csv << headers

              @orders.each do |order|
                ship_address = order.ship_address

                order.line_items.each do |line_item|
                  csv_line = []
                  csv_line << order.updated_at
                  csv_line << order.completed_at
                  csv_line << order.number
                  csv_line << order.name
                  csv_line << ship_address.company
                  csv_line << ship_address.full_name
                  csv_line << ship_address.address1
                  csv_line << ship_address.address2
                  csv_line << ship_address.city
                  csv_line << ship_address.state_text
                  csv_line << ship_address.zipcode
                  csv_line << ship_address.phone
                  csv_line << ship_address.country.name
                  csv_line << line_item.variant.name
                  csv_line << line_item.variant.option_values.map(&:name).join(", ")
                  # csv_line << line_item.variant.option_values.first(:conditions => "option_type_id = 2").name
                  csv_line << line_item.quantity
                  csv_line << line_item.total.to_s
                  csv_line << order.payments.map(&:payment_method).map(&:name).join(", ") rescue nil
                  csv_line << "92"
                  csv_line << ""
                  csv << csv_line
                end
              end
            end
            send_data orders_export, :type => 'text/csv', :filename => "Orders-#{Time.now.strftime('%Y%m%d')}.csv"
          end
        end
      end
    end
  end
end
