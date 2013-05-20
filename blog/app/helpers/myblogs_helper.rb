module MyblogsHelper
  def join_tags(myblog)
     myblog.tags.map { |t| t.name }.join(", ")
   end
end
