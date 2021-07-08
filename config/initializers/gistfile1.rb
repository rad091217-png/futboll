# will_paginateで出力されるページネーションの日本語化
WillPaginate::ViewHelpers.pagination_options = {
  :class => "pagination",
  :previous_label => "&laquo;前へ",
  :next_label => "次へ&raquo;",
  :inner_window => 4, # links around the current page
  :outer_window => 1, # links around beginning and end
  :separator => " ", # single space is friendly to spiders and non-graphic browsers
  :param_name => :page,
  :params => nil,
  :renderer => "WillPaginate::ViewHelpers::LinkRenderer",
  :page_links => true,
  :container => true,
}
