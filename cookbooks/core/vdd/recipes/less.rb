Package "rubygems"

Execute "gem install less" do
    not_if "which less"
end
Execute "gem install rb-inotify"
