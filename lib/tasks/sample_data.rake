namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_relationships
  end
 end

 def make_users
    admin = User.create!(:name => "Example User",
                 :email => "example@rpi.edu",
                 :password => "foobar",
                 :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@rpi.edu"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end

  def make_relationships
    users = User.all
    user = users.first
    cheqeds = users[1..50]
    cheqers = users[3..40]
    cheqeds.each { |cheqed| user.cheq!(cheqed) }
    cheqers.each { |cheqer| cheqer.cheq!(user) }
  end 