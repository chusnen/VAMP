php_pear "PHP_CodeSniffer" do
	not_if do
	File.exists?("/usr/share/php/PHP/CodeSniffer")
	end
  version :"1.5.4"
  action :install
end

bash "install_coder" do
  not_if do
    File.exists?("/home/vagrant/.drush/coder")
  end
  user "root"
  cwd "/home/vagrant/.drush/"
  code <<-EOH
    wget http://ftp.drupal.org/files/projects/coder-7.x-2.2.tar.gz
    tar -zxf coder-7.x-2.2.tar.gz
    chown vagrant:vagrant coder -R	
    rm coder-7.x-2.2.tar.gz
    ln -sv /home/vagrant/.drush/coder/coder_sniffer/Drupal /usr/share/php/PHP/CodeSniffer/Standards
  EOH
end

directory "/home/vagrant/.drush/drupalsecure" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end

git "/home/vagrant/.drush/drupalsecure" do
  repository "git://git.drupal.org/sandbox/coltrane/1921926.git"
  revision "master"
  action :sync
end


bash "ln_to_drupalsecure" do
not_if do
    File.exists?("/usr/share/php/PHP/CodeSniffer/Standards/DrupalSecure")
  end
 user "root"
 code <<-EOH
   ln -s /home/vagrant/.drush/drupalsecure/DrupalSecure /usr/share/php/PHP/CodeSniffer/Standards
 EOH
end

bash "install_drupalpractice" do
  not_if do
    File.exists?("/home/vagrant/.drush/drupalpractice")
  end
  user "root"
  cwd "/home/vagrant/.drush/"
  code <<-EOH
    wget http://ftp.drupal.org/files/projects/drupalpractice-7.x-1.0.tar.gz
    tar -zxf drupalpractice-7.x-1.0.tar.gz
    chown vagrant:vagrant drupalpractice -R	
    rm drupalpractice-7.x-1.0.tar.gz
    cd /usr/share/php/PHP/CodeSniffer/Standards/
    mkdir DrupalPractice
    ln -sv /home/vagrant/.drush/drupalpractice/DrupalPractice /usr/share/php/PHP/CodeSniffer/Standards/DrupalPractice
  EOH
end

directory "/etc/codespell/" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end
git "/etc/codespell" do
     repository "https://github.com/lucasdemarchi/codespell"
     revision "master"
     action :sync
end

bash "ln_to_codespell" do
not_if do
    File.exists?("/usr/local/bin/codespell.py")
  end
 user "root"
 code <<-EOH
   ln -s /etc/codespell/codespell.py /usr/local/bin/
 EOH

end


bash "install_pareviewsh" do
  not_if do
    File.exists?("/home/vagrant/.drush/pareviewsh")
  end
  user "root"
  cwd "/home/vagrant/.drush/"
  code <<-EOH
    wget http://ftp.drupal.org/files/projects/pareviewsh-7.x-1.4.tar.gz
    tar -zxf pareviewsh-7.x-1.4.tar.gz
    chown vagrant:vagrant pareviewsh -R	
    rm pareviewsh-7.x-1.4.tar.gz
  EOH
end

bash "change_permisions" do
user "root"
code <<-EOH
    chown vagrant:vagrant /usr/share/php/PHP/CodeSniffer/Standards/coder -R	
    chown vagrant:vagrant /usr/share/php/PHP/CodeSniffer/Standards/DrupalPractice -R
    chown vagrant:vagrant /usr/share/php/PHP/CodeSniffer/Standards/DrupalSecure -R
  EOH

end

bash "executable_pareview.sh" do
  not_if do
  File.exists?("/usr/local/bin/pareview.sh")
  end
  user "root"
  code <<-EOH
  ln -s /home/vagrant/.drush/pareviewsh/pareview.sh /usr/local/bin
  EOH

end

