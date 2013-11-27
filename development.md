ruby-trustedsearch
==================
These are notes for TRUSTEDSearch team to follow as new versions of the gem are built.


## Making changes to gem
Make sure you have the latest tags

	git fetch --tags

* Commit changes locally
* Merge topical branch into master
* Tag local Tag Branch:

		git tag -a vX.X.X -m 'New Feature: Add some new feature.'

Push to master and push tags to master

	git push origin master
	git  push  --tags

* Increment the VERSION file to

		X.X.X

* Upate trustedsearch.gemspec s.version to version.
	
		s.version     = 'X.X.X'

* Run at cmd

		gem update --system
		gem build trustedsearch.gemspec
		gem push trustedsearch-X.X.X.gem



### Helpful reads about github releases/tags and gems.
	
* [http://wptheming.com/2011/04/add-remove-github-tags/](http://wptheming.com/2011/04/add-remove-github-tags/)
* [https://help.github.com/articles/creating-releases](https://help.github.com/articles/creating-releases)
* [https://github.com/blog/1547-release-your-software](https://github.com/blog/1547-release-your-software)
* [http://guides.rubygems.org/patterns/](http://guides.rubygems.org/patterns/)