module Jekyll

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag_index'
        dir = site.config['tag_dir'] || 'tags'

        site.tags.each_key do |tag|
          tag_posts = site.tags[tag]
          tag_page_count = TagPager.calculate_pages(tag_posts, site.config['paginate'].to_i)

          (1..tag_page_count).each do |page_number|
            tag_pager = TagPager.new(site, page_number, tag_posts, tag, tag_page_count)
            tag_dir = File.join('tags', tag, page_number > 1 ? "page#{page_number}" : '')
            tag_page = TagPage.new(site, site.source, tag_dir, tag)
            tag_page.pager = tag_pager
            site.pages << tag_page
          end
        end

      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      layout = site.config['tag_index']['layout'] || 'tag_index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), layout)
      self.data['tag'] = tag
    end
  end

  class TagPager < Jekyll::Paginate::Pager
    attr_reader :tag

    def initialize(site, page, all_posts, tag, num_pages = nil)
      @tag = tag
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['tag'] = @tag
      liquid
    end
  end

  class TagUrlTag < Liquid::Tag

    def initialize(tag_name, tag_var_name, tokens)
      super
      @tag_var_name = tag_var_name
    end

    def render(context)

      tag_name = context[@tag_var_name]
      return "/tags/#{tag_name}"
    end
  end
end

Liquid::Template.register_tag('tag_url', Jekyll::TagUrlTag)
