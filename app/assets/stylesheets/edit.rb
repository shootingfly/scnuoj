theme = %w(cerulean cosmo cyborg darkly flatly journal lumen paper readable sandstone simplex slate spacelab superhero united yeti)
theme.each do |t|
`sed -i "s/yeti/#{t}/g" #{t}.scss`
end
