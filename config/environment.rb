#encoding: utf-8
# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Dgame::Application.initialize!

require 'will_paginate'
WillPaginate::ViewHelpers.pagination_options[:previous_label] = '上一页'
WillPaginate::ViewHelpers.pagination_options[:next_label] = '下一页'
