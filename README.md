# just-want-to-pass-dynamodb-travisci
This is a simple project in which I'm trying to get my php dynamodb usage to pass a successful build in travis-ci

# Dev notes
To check .travis.yml
'''
sudo apt-get install ruby rubygems
gem install travis-lint
travis-lint
'''

To encrypt env vars in .travis.yml
'''
gem install travis
travis encrypt 'SOMEVAR=secretvalue' (no need for double quotes around secretvalue)
'''

To add git branches
'''
git branch lastsuccess asdfhaksjrfhuihwer8923489234uih23i4h
git push origin lastsuccess
git branch -D lastsuccess
git push origin --delete lastsuccess
'''
