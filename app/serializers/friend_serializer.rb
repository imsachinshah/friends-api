class FriendSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :location, :twitter, :phone, :email
end
