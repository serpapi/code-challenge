# frozen_string_literal: true

##
# A class to recursively scrap the data of HTML documents using
# the concept of semi-declarative stencils (data-shape Hash with micro-post-processing)
#
class HtmlScraper
  SELECTOR_TYPES = {
    css: :css,
    xpath: :xpath,
    regexp: :scan
  }.freeze

  def parse(html: '', stencils: {}, &final_touch)
    result = Hash.new(nil)

    stencils.each_pair do |name, stencil|
      # if Stencil is a Hash and selector was provided
      next unless stencil.respond_to?(:key?) && stencil.key?(:selector)

      # parse node (HTML) and present results as an Array
      preliminary_result = parse_node(html, stencil[:selector]).to_a

      # cast node to string or get text if we've got just one result
      preliminary_result = handle_single_result(preliminary_result, stencil)

      # recursively parse children if stencil contains children section
      preliminary_result = handle_children(preliminary_result, stencil)

      # yield all the callbacks for parsed nodes
      preliminary_result = handle_callbacks(preliminary_result, stencil)

      result[name] = preliminary_result
    end

    # put finishing touches to your data
    result = final_touch.call(result) if block_given?

    result
  end

  private

  def parse_node(node, selector = '')
    selector_type, selector = handle_selector(selector)

    return unless selector_type

    if node.respond_to?(selector_type)
      node.send(selector_type, selector)
    elsif node.to_s.respond_to?(selector_type)
      node.to_s.send(selector_type, selector)
    else
      raise NotImplementedError, "#{selector_type} should be implemented for #{@node.class}"
    end
  end

  def handle_single_result(node, stencil)
    if node.count == 1 && !stencil.key?(:children)
      n = node.first

      return n.text if stencil.fetch(:text, false)
      return n.to_s if stencil.fetch(:html, false)
      return n[stencil.fetch(:attr).to_s] if stencil.fetch(:attr, false)

      return n
    end

    node
  end

  def handle_callbacks(node, stencil)
    node = node.dup

    # if we have more tan one result
    if node.respond_to?(:map!)
      # apply a callback to each (if provided)
      if stencil[:callback]&.respond_to?(:call)
        node.map! { |pr| stencil[:callback].call(pr) }.reject!(&:nil?)
      end
    else # if we've got one result
      # call a callback (if provided)
      node = stencil[:callback].call(node) if stencil[:callback] && stencil[:callback].respond_to?(:call)
    end

    node
  end

  def handle_children(node, stencil)
    if stencil.key?(:children)
      children = []

      node.each do |n|
        children << parse(html: n, stencils: stencil[:children])
      end

      node = children.count == 1 ? children.first : children
    end

    node
  end

  def handle_selector(selector)
    sel = selector.scan(/\[(#{SELECTOR_TYPES.keys.map(&:to_s).join('|')})\]\s(.*$)/)
    return if sel.empty?

    sel_type = sel[0][0].to_sym
    sel_type = SELECTOR_TYPES[sel_type] if SELECTOR_TYPES.keys.include?(sel_type)

    return unless sel_type

    sel = if sel_type == :scan
            Regexp.new(sel[0][1], 'ix')
          else
            sel[0][1]
          end

    [sel_type, sel]
  end
end

if __FILE__ == $PROGRAM_NAME
end
