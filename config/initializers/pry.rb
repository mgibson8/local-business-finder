require "awesome_print"
AwesomePrint.pry!

old_prompt = Pry.config.prompt
env_str = "#{Rails.application.class.parent}-#{Rails.env}"
if Rails.env.production?
  # Can't do this because it messes with bash history for some reason
  # env = Pry::Helpers::Text.red(env_str)
  env = "\001\e[0;31m\002#{env_str}\001\e[0m\002"
else
  # Can't do this because it messes with bash history for some reason
  # env = Pry::Helpers::Text.green(env_str)
  env = "\001\e[0;32m\002#{env_str}\001\e[0m\002"
end
Pry.config.prompt = [
  proc {|*a| "#{env} #{old_prompt.first.call(*a)}"},
  proc {|*a| "#{env} #{old_prompt.second.call(*a)}"},
]

Pry.config.prompt_name = ''
