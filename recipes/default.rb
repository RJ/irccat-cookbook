include_recipe "runit"
include_recipe "java"
include_recipe "ant"

if node[:irccat][:create_user]
    user node[:irccat][:user] do
        action :create
    end
end

directory '/opt/irccat' do
    user node[:irccat][:user]
end

git "/opt/irccat" do
    user node[:irccat][:user]
    repository node[:irccat][:git_url]
    reference "master"
    action :checkout
end

bash "Ensure /opt/irccat belongs to #{node[:irccat][:user]}" do
    code "chown -R #{node[:irccat][:user]} /opt/irccat"
end

script "Compile IRCCat" do
    interpreter "bash"
    user node[:irccat][:user]
    cwd '/opt/irccat'
    code 'ant dist'
    creates "/opt/irccat/dist/irccat.jar"
end

directory "/etc/irccat" do
    action :create
    owner node[:irccat][:user]
end

template "/etc/irccat/irccat.xml" do
    source "irccat.xml.erb"
    owner node[:irccat][:user]
    mode "0644"
    notifies :restart, "service[irccat]"
end

runit_service "irccat" do
    supports :status => false, :restart => false
    action [ :enable, :start ]
end
