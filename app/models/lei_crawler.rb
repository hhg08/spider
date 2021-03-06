#encoding:utf-8
class LeiCrawler < ActiveRecord::Base
	class << self
		def leida_urls
			urls = []
			list_type = ["g_pay_not","g_pay"]
			list_type_num = {"g_pay_not"=>11,"g_pay"=>12}
			children_type_ids = {"g_pay_not"=>[21,36,37,38,39,40,41,42,43,44,46,47,48,49,50,51,52,53,54],"g_pay"=>[21,36,37,38,39,40,41,42,43,44,46,47,48,49,50,51,52,53,54]}
			list_type.each do |list|
				children_type_ids[list].each do |type_id|
					urls << "http://www.ann9.com/#{type_id}_#{list_type_num[list]}?p=0&n=1"
				end
			end
			urls
		end

		def save_leida_data
			urls = leida_urls
			p "============#{urls.size}"
			urls.each do|url|
				sleep(20)
				p "===========#{url}"
				agent = Mechanize.new{|m|m.user_agent = "Mac Safari"}
				page = agent.get(url) rescue nil
				next if page.nil?
				next if page.css("div .padsearch .padsubsearch span").empty?
				next if page.css("div .padappbody .padtit1xia1 .padhuang").empty?
				p_list_type = page.css("div .padsearch .padsubsearch span")[3].text
				g_type = page.css("div .padsearch .padsubsearch span")[9].text
				next if (p_list_type.nil? || g_type.nil?)

				page.css("div .padappbody .padtit1xia1 .padhuang").each do |padhuang|
					g_title = padhuang.css("a")[0]["title"]
					next if g_title.nil?
					self.create(p_list_type:p_list_type,game_type:g_type,g_title:g_title) rescue nil
				end
			end
		end

		def export_datas
			CSV.open("#{Rails.root}/public/lei_crawler.csv", "w") do |csv|
				csv << ["榜单类型","类别","名称"]
				LeiCrawler.all.each do |crawler|
					csv << [crawler.p_list_type,crawler.game_type,crawler.g_title]
				end
			end
		end
	end
end
