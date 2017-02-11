module Jekyll

  class TagPage < Jekyll::Page

    def initialize(site, base, dir, tag)

      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
    end

  end

  class TagPageGenerator < Jekyll::Generator
    safe true

    def generate(site)

      if site.config['tag']
        site.tags.each_key do |tag|

          posts = site.tags[tag]
          page_count = Jekyll::Paginate::Pager.calculate_pages(posts, site.config['paginate'].to_i)

          (1..page_count).each do |page_number|

            tag_dir = File.join('tags', tag, page_number > 1 ? "page#{page_number}" : '')

            pager = Jekyll::Paginate::Pager.new(site, page_number, posts, page_count)

            page = TagPage.new(site, site.source, tag_dir, tag)
            page.data['tag'] = tag
            page.pager = pager
            site.pages << page
          end
        end
      end

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
