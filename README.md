# just-want-to-pass-dynamodb-travisci
[![Build Status](https://secure.travis-ci.org/shadiakiki1986/just-want-to-pass-dynamodb-travisci.png)](http://travis-ci.org/shadiakiki1986/just-want-to-pass-dynamodb-travisci)


This is a simple project in which I'm trying to get my php dynamodb usage to pass a successful build in travis-ci. Its related issue is [here](https://github.com/aws/aws-sdk-php/issues/588#issuecomment-106895327), and my travis-ci builds are [here](https://travis-ci.org/shadiakiki1986/just-want-to-pass-dynamodb-travisci).

In a nutshell, it turned out that I needed to use GnuTLS 3.1.28 instead of 2.12. Since travis-ci workers still use ubuntu 12.04 (open [issue](https://github.com/travis-ci/travis-ci/issues/2046)), I needed to install gnutls and curl from source. It worked for a regular EC2 instance, but not on the travis-ci workers. I spawned [gnutls-3.1.-travisci](https://github.com/shadiakiki1986/gnutls-3.1-travisci) to tackle this, but I [failed](https://travis-ci.org/shadiakiki1986/gnutls-3.1-travisci) miserably. I suspect that this is related to one of two:
* how to compile libcurl-gnutls.so file: I asked on [stackoverflow](http://stackoverflow.com/questions/30572479/compiling-gnutls-3-1-28-on-travis-ci), [curl-and-php](http://curl.haxx.se/mail/curlphp-2015-06/0000.html), [gnutls-help](http://lists.gnutls.org/pipermail/gnutls-help/2015-June/003881.html)
* travis-ci workers'' use of `phpenv: asked travis-ci support email

10 days into this, and still no sign of a helpful hint, I'm giving up on trying to get php tests that use aws-php-sdk / dynamodb on travis-ci to pass

# Some dev notes for myself
To check .travis.yml

    sudo apt-get install ruby rubygems
    gem install travis-lint
    travis-lint

To encrypt env vars in .travis.yml

    gem install travis
    travis encrypt 'SOMEVAR=secretvalue' (no need for double quotes around secretvalue)

To add git branches

    git branch lastsuccess asdfhaksjrfhuihwer8923489234uih23i4h
    git push origin lastsuccess
    git branch -D lastsuccess
    git push origin --delete lastsuccess
