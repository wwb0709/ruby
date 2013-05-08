require 'rubygems'
require 'mechanize'
require 'pp'

user = 'wwb1111'
password = 'wwb0916'

agent = Mechanize.new
agent.user_agent_alias = 'Mac Safari'
page = agent.get 'http://www.iteye.com/login'


form = page.form_with(:action => '/login')
form.field_with(:name => "name").value = user
form.field_with(:name => "password").value = password
search_results = agent.submit form
pp search_results.body
