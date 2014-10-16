angel-list
==========
Deploying application to Ubuntu
1) create application group and user
 sudo groupadd --system rubyapps
 sudo useradd --system --gid rubyapps --shell /bin/bash --home /var/rubyapps/angel_list angel_list


 sudo mkdir -p /var/rubyapps/angel_list
 sudo chown angel_list /var/rubyapps/angel_list

 sudo su - angel_list

2) Install RVM and ruby
 curl -L https://get.rvm.io | bash -s stable
 echo 'source ~/.rvm/scripts/rvm' >> ~/.bash_aliases && bash
 rvm autolibs disable
 rvm requirements

 rvm install ruby-2.0.0-p481

3) Install application
  cd ~
  mkdir ./current_version
  git clone https://github.com/codevog/angel-list.git ./current_version
  cd ./current_version
  rvm use ruby-2.0.0-p481@angellist --rvmrc --create
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed

4) Run application
   rake angellist:load_companies

5) database file location: /var/rubyapps/angel_list/current_version/db/development.sqlite3

