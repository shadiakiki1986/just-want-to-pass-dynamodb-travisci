# just-want-to-pass-dynamodb-travisci
[![Build Status](https://secure.travis-ci.org/shadiakiki1986/just-want-to-pass-dynamodb-travisci.png)](http://travis-ci.org/shadiakiki1986/just-want-to-pass-dynamodb-travisci)


This is a simple project in which I'm trying to get my php dynamodb usage to pass a successful build in travis-ci. Its related issue is [here](https://github.com/aws/aws-sdk-php/issues/588#issuecomment-106895327), and my travis-ci builds are [here](https://travis-ci.org/shadiakiki1986/just-want-to-pass-dynamodb-travisci).

In a nutshell, it turned out that I needed to use GnuTLS 3.1.28 instead of 2.12. Since travis-ci workers still use ubuntu 12.04 (open [issue](https://github.com/travis-ci/travis-ci/issues/2046)), I needed to install gnutls and curl from source. It worked for a regular EC2 instance, but not on the travis-ci workers. I spawned [gnutls-3.1.-travisci](https://github.com/shadiakiki1986/gnutls-3.1-travisci) to tackle this, but I failed miserably. I suspected that this is related to one of two:
* how to compile libcurl-gnutls.so file: I asked on [stackoverflow](http://stackoverflow.com/questions/30572479/compiling-gnutls-3-1-28-on-travis-ci), [curl-and-php](http://curl.haxx.se/mail/curlphp-2015-06/0000.html), [gnutls-help](http://lists.gnutls.org/pipermail/gnutls-help/2015-June/003881.html)
* travis-ci workers'' use of `phpenv: asked travis-ci support email

10 days into this, and still no sign of a helpful hint, I gave up on trying to get php tests that use aws-php-sdk / dynamodb on travis-ci to pass. The next morning, as I embarked on my [journey](https://github.com/shadiakiki1986/zboota-server) abandoning [CI](https://en.wikipedia.org/wiki/Continuous_integration), I paused. I felt the breeze go through my nostrils carrying the stench of the dead jasmine flowers on my desk. The very flowers that stood by me as I went through countless lines of logs, making my way in and out of directories never heard of before, are now dead, and I have no memories of them but midnights of giving up and mornings of discouragement. I paused. I said to myself "Nay! I shan't let the world have its way. I shall try again". And so I did. I felt like I was [plucking my hair and dying that way](https://youtu.be/FH7crqRvhhc?t=531). And then, as drivers honked and cursed on the [streets](https://en.wikipedia.org/wiki/Achrafieh) below my office, it struck me. I installed a separate php5 CLI binary on the travis-ci worker, other than the ones automatically used by phpenv, I explicitly referenced it with `/usr/bin/php5`, and it worked. It turned out that the php binaries in phpenv were not automatically linking properly against the libraries I was installing in `/usr/local/lib`, whereas the php CLI that I installed separately was doing so correctly. 

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
