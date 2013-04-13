module Hospice
  class Category
    include Support::Storer

    attr_reader :title

    def self.build(title)
      instance = all.select{|x| x.title == title}.first
      instance || Category.new(title)
    end

    def id
      object_id
    end

    def packages
      Package.all.select{|p| p.category.id == id}.sort_by{|x| x.title}
    end

    private

    def initialize(title)
      @title = title
      store
    end
  end
end