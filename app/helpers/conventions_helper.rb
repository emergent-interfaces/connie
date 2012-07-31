module ConventionsHelper
  def default_convention_name
    print "default: #{default_convention_set?}"
    return "All Conventions" unless default_convention_set?
    default_convention.name
  end

  def session_filter(obj)
    if default_convention_set?
      return [default_convention, obj] if obj.class.ancestors.include?(ActiveRecord::Base)
      return "/conventions/#{default_convention.id}#{obj}" if obj.class == String
    else
      return obj
    end
  end

  def conventions_for_select
    collection = Convention.all
    collection << Convention.new(:name => 'All Conventions')

    selected = default_convention.id if default_convention_set?
    selected = "" unless default_convention_set?

    options_string = options_from_collection_for_select(collection,"id","name",selected)
  end
end
