object @photo do
  attributes :src, :name
  attributes :drawing
  attribute :height
  node do |p|
    { label: p.name }
  end

  child :components do
    attributes :name, :height
  end

end
