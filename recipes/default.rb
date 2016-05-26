include_recipe "runit"
include_recipe "java"
include_recipe "ant"

if node[:irccat][:create_user]
    user node[:irccat][:user] do
        action :create
    end
end

git "/opt/irccat" do
    repository node[:irccat][:git_url]
    reference "master"
    action :checkout
end

script "Compile IRCCat" do
    interpreter "bash"
    user "root"
    code <<-EOF
    cd /opt/irccat
    chown -R #{node[:irccat][:user]} .
    sudo -Eu #{node[:irccat][:user]} ant dist
    EOF
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
    default_logger true
    supports :status => false, :restart => false
    action [ :enable, :start ]
end
