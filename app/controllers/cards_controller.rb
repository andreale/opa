class CardsController < ApplicationController
  layout false

  def erdnuss
    @erdnuss_tag_text = ErdnussScraper.new.get_erdnuss_tag
  end

  def foo
  end

  def bar
  end
end
