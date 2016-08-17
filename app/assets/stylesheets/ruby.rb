theme = %w(cerulean cosmo cyborg darkly flatly journal lumen paper readable sandstone simplex slate spacelab superhero united yeti)
theme.each do |t|
  `cp theme.scss #{t}.scss`
end
