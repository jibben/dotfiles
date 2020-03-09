set -x PATH $PATH $GOROOT/bin $GOPATH/bin
set -x PATH $PATH $CUE_CLIENT_SRC
set -x PATH $PATH /usr/local/opt/ruby/bin
set -x PATH $PATH /usr/local/opt/libpq/bin

source /Users/jibben/google-cloud-sdk/path.fish.inc
rvm default

alias cueobj='go run $CUE_BACKEND_SRC/playground/printobject/printobject.go'
