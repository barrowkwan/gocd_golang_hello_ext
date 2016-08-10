#!/bin/sh

GOPATH=`pwd`
export GOPATH

rm -rf $GOPATH/bin/*

go get github.com/barrowkwan/gocd_golang_hello_ext

if [[ -f $GOPATH/bin/go-junit-report ]]; then
  echo "Remove binary : $GOPATH/bin/go-junit-report"
  rm -rf $GOPATH/bin/go-junit-report
fi
if [[ -d src/github.com/jstemmer/go-junit-report ]]; then
  echo "Remove external library : github.com/jstemmer/go-junit-report"
  rm -rf src/github.com/jstemmer/go-junit-report
fi
echo "Get github.com/jstemmer/go-junit-report"
go get -d github.com/jstemmer/go-junit-report

go build -o $GOPATH/bin/go-junit-report github.com/jstemmer/go-junit-report
if [[ -f testreport.xml ]]; then
  echo "Remove old test report : testreport.xml"
  /bin/rm -rf testreport.xml
fi
go test -v github.com/barrowkwan/gocd_golang_hello_ext/... | $GOPATH/bin/go-junit-report > testreport.xml


echo "======================="
echo "Building binary for OSX"
GOOS=darwin go build -o $GOPATH/bin/helloworld_osx github.com/barrowkwan/gocd_golang_hello_ext
echo "======================="


echo "======================="
echo "Building binary for linux"
GOOS=linux go build -o $GOPATH/bin/helloworld_linux github.com/barrowkwan/gocd_golang_hello_ext
echo "======================="
