require 'rails_helper'

describe User do

  let(:user){build(:user)}
  let(:bad_user){build(:user, password: 'pass')}
  let(:short_name){build(:user, name: 'j')}
  let(:bad_email){build(:user, email: user.email)}

  it "creats a user" do
    expect(user).to be_valid
  end

  it "has a validates password length" do
    expect(bad_user).to_not be_valid
  end

  it "validates name length" do
    expect(short_name).to_not be_valid
  end

  it "requires a unique email" do
    user.save
    expect(bad_email).to_not be_valid
  end

  it "skips password validation if nil on update" do
    user.save
    user.update_attributes(name: "merf")
    expect(user.name).to eq("merf")
  end

  it "has is associated with secrets" do
    expect(User.reflect_on_association(:secrets).macro).to eq(:has_many)
  end


end


# has_secure_password
#
# has_many :secrets, :foreign_key => :author_id
#
# validates :name, :email, :presence => true
# validates :name, :length => { :in => 3..20 }
# validates :email, :uniqueness => true
# validates :password,
#           :length => { :in => 6..16 },
#           :allow_nil => true
