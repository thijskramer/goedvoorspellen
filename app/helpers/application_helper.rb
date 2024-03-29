module ApplicationHelper
	def bool_icon(val)
		icon = val ? '<span class="glyphicon glyphicon-ok green"></span>' : '<span class="glyphicon glyphicon-remove red"></span>'
		icon.html_safe
	end
	
	def flag(isocode, size=32)
		img = '<img src="/flags/'+size.to_s+'/' + isocode.downcase + '.png" class="flag s'+ size.to_s+'">'
		img.html_safe
	end

    def gravatar_url(email)
        gravatar_id = Digest::MD5::hexdigest(email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png"
    end

    def avatar_visibility_options
        options = Array.new
        options << ["Aan iedereen", "PUBLIC"]
        options << ["Aan ingelogde gebruikers", "USERS"]
        options << ["Alleen aan deelnemers van poules waarin ik deelneem", "POULE"]
        options << ["Alleen aan mijzelf", "SELF"]
        options
    end

    def selection_type_options
        options = Array.new
        options << ["Voorlopig", "VOORLOPIG"]
        options << ["Definitief", "DEFINITIEF"]
        options
    end

    def markdown(text)
      render_options = {
        # will remove from the output HTML tags inputted by user 
        filter_html:     true,
        # will insert <br /> tags in paragraphs where are newlines 
        # (ignored by default)
        hard_wrap:       true, 
        # hash for extra link options, for example 'nofollow'
        link_attributes: { rel: 'nofollow' },
        # more
        # will remove <img> tags from output
        no_images: true,
        # will remove <a> tags from output
        no_links: true,
        # will remove <style> tags from output
        no_styles: true,
        # generate links for only safe protocols
        safe_links_only: true
        # and more ... (prettify, with_toc_data, xhtml)
      }
      renderer = Redcarpet::Render::HTML.new(render_options)

      extensions = {
        #will parse links without need of enclosing them
        autolink:           true,
        # blocks delimited with 3 ` or ~ will be considered as code block. 
        # No need to indent.  You can provide language name too.
        # ```ruby
        # block of code
        # ```
        fenced_code_blocks: true,
        # will ignore standard require for empty lines surrounding HTML blocks
        lax_spacing:        true,
        # will not generate emphasis inside of words, for example no_emph_no
        no_intra_emphasis:  true,
        # will parse strikethrough from ~~, for example: ~~bad~~
        strikethrough:      true,
        # will parse superscript after ^, you can wrap superscript in () 
        superscript:        true,
        underline: true
        # will require a space after # in defining headers
        # space_after_headers: true
      }
      Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
    end
end
