class WellComScraper
  ADDRESS = 'https://well-com-ch-sodexo.com/'
  DAY_RXP = /.+Angebot am\s+/i

  INCLUDE_MARKETING = true

  def get_well_com_menu
    # puts '----'
    # puts "day_headlines: #{day_headlines}"
    # puts '----'
    # puts "menu_blocks: #{menu_blocks}"
    # puts '----'

    # { 'Montag' => ['Foo', 'bar'], 'Dienstag' => ['Baz', 'quz'] }
    Hash[day_headlines.zip(menu_blocks)]
  end

  private

  def mechanize
    @mechanize ||= Mechanize.new
  end

  def page
    @page ||= mechanize.get(ADDRESS)
  end

  def day_headlines
    @day_headlines ||= page.search('.screen4-title').map do |blk|
      next if !INCLUDE_MARKETING && !(blk.text =~ DAY_RXP)
      blk.text.gsub(DAY_RXP, '')
    end.compact
  end

  def menu_blocks
    @menu_blocks ||= page.search('.screen4-subtitle').map do |blk|
      blk.search('p').each_with_object([]) do |p, a|
        text = p.text.strip
        next if !INCLUDE_MARKETING && !(text =~ /(^Special)|(^Sandwiches)/i)
        text
        is_menu_text = p.attr('class').blank?
        a << text if is_menu_text
      end
    end.flatten.each_slice(2).to_a
  end
end
