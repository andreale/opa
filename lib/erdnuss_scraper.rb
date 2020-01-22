class ErdnussScraper
  ADDRESS = 'https://www.chiang-mai.ch/menu/'
  PROXY_HOST = 'clientproxy.corproot.net'
  PROXY_PORT = 8079
  MATCH_RXP = /Satè Gai/i

  def get_erdnuss_tag
    menu = Hash[day_headlines.zip(menu_blocks)]

    # menu.each do |heading, menu_items|
    #   puts heading
    #   menu_items.each do |mis|
    #     puts ">> #{mis[:title]}"
    #     puts ">> #{mis[:description]}"
    #   end
    # end and ''

    peanut_day = menu.detect do |_heading, menu_items|
      menu_items.detect { |mi| mi[:title] =~ MATCH_RXP }
    end

    if peanut_day
      peanut_day.first
    else
      "not detected :("
    end
  end

  private

  def mechanize
    @mechanize ||= Mechanize.new do |agent|
      agent.set_proxy(PROXY_HOST, PROXY_PORT)
    end
  end

  def page
    @page ||= mechanize.get(ADDRESS)
  end

  def day_headlines
    @day_headlines ||= page.search('.sqs-block-html').map do |blk|
      next unless blk.text =~ /uhr$/i
      blk.text
    end.compact
  end

  def menu_blocks
    @menu_blocks ||= page.search('.sqs-block-menu').map do |blk|
      menu_items = blk.search('.menu-item')
      foo = menu_items.map do |mi|
        title = mi.at('.menu-item-title').text rescue 'err'
        description = mi.at('.menu-item-description').text rescue 'err'
        { title: title, description: description }
      end
    end.compact
  end
end
