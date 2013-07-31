class StuInfo
	
    require 'rubygems'
    require 'json'
    require 'mongo'
    require 'mongoid'
	
    include Mongoid::Document
    include Mongoid::Timestamps
    
	#load .yml file (database_name), sth like that
	#MONGOID_ENV?
    Mongoid.load!("mongoid.yml", :development);
    # Table fields
    field :_id,           :type => String
    field :gender,        :type => String
    field :info,        :type => Hash
    
	def assoc( _id="110320071", gender="M", info =  {"math" => "132", "english" => "113", "chinese" => "97"})
		
		#Iterator
		if (ret = StuInfo.where(_id: _id).first ) != nil
			#update
			ret.gender = gender
			ret.info = info
			ret.save
			return ret
		end
		
		obj = StuInfo.new(_id: _id, gender: gender, info: info)
		obj.save
		obj
    end
	
end

p=StuInfo.new()
p.assoc("123456", "F", {"math" => "932", "english" => "64", "chinese" => "937"})
p.assoc("4tgrrg", "M", {"madth" => "93fd2", "englfdish" => "6345t4", "chinwtefese" => "9gdsg37"})

puts "done"
