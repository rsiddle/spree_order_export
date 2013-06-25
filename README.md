Order Export
===========

Order export is a quick and dirty extension that exports line items to a CSV file.

You can install it simply by adding it to the Gemfile of your Spree project:
`gem 'spree_order_export', :git => 'git://github.com:therealkris/spree-order-export.git'`
And then running `bundle install`

The extension adds a report under the 'Reports' tab which allows the export to be constrained to a date range, and exports a CSV file which should be in a blend of line breaks and seperaters which should work with Microsoft Office Excel.

It exports the following fields, in the following order:
* Order number
* Customer Full Name
* Customer Address (Address 1, Address 2 if there, Country)
* Customer Phone
* Customer Email
* Variant (Product) name
* Variant (Product) quantity
* Order total
* Order payment method.

