collection @photos do
	attributes :src, :name, :height
	attributes :drawing
	node do |p|
	  { :label =>  p.name }
	end
	child :components do
		attributes :name, :height
	end
end
