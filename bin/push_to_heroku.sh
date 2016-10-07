#!/usr/bin/ruby
`j oj`
`git checkout develop`
`git add -A`
`git commit -m "#{Time.now}"`
`git push heroku develop:master`
