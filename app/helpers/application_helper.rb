module ApplicationHelper
  include Pagy::Frontend

  def tailwind_paginator(pagy)
    # return unless pagy.pages > 1

    content_tag(:nav, class: "flex items-center justify-between border-t border-gray-200 px-4 sm:px-0 mt-6", "aria-label": "Pagination") do
      tags = []

      tags << (
        if pagy.prev
          link_to(pagy_url_for(pagy, pagy.prev), class: "relative inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50") do
            content_tag(:span, "Previous")
          end
        else
          content_tag(:span, "Previous", class: "relative inline-flex items-center rounded-md bg-gray-100 px-3 py-2 text-sm font-semibold text-gray-400 ring-1 ring-inset ring-gray-300 cursor-not-allowed")
        end
      )

      tags << content_tag(:div, class: "hidden md:flex") do
        inner_tags = []
        pagy.series.each do |item|
          case item
          when Integer
            inner_tags << link_to(item, pagy_url_for(pagy, item), class: "relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 mt-3")
          when String
            inner_tags << content_tag(:span, item, class: "relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 cursor-not-allowed mt-3")
          when :gap
            inner_tags << content_tag(:span, "...", class: "relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 mt-3")
          when :current
            inner_tags << content_tag(:span, item, class: "relative z-10 inline-flex items-center bg-blue-600 px-4 py-2 text-sm font-semibold text-white focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 mt-3")
          end
        end
        safe_join(inner_tags)
      end

      tags << (
        if pagy.next
          link_to(pagy_url_for(pagy, pagy.next), class: "relative inline-flex items-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50") do
            content_tag(:span, "Next")
          end
        else
          content_tag(:span, "Next", class: "relative inline-flex items-center rounded-md bg-gray-100 px-3 py-2 text-sm font-semibold text-gray-400 ring-1 ring-inset ring-gray-300 cursor-not-allowed")
        end
      )

      safe_join(tags)
    end
  end

  def signed_in?
    Current.session.present?
  end

  def current_user
    Current.session&.user
  end
end
