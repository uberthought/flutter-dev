# Getting started

spin up the dev container in vs code dev container
open terminal

flutter create demo
cp debug.sh demo
cd demo
chmod +x debug.sh
./debug.sh

# Description

This is the build enironment for flutter android, web and linux. The web target is the only
one that's tested. Flutter doctor indicates they should work, but you're on your own for
those two.

The only other thing of note is the file debug.sh is the command to run a debug web server
without having chrome installed. Feel free to open it up and have a lookL all you need is the
undocmented -d web-server option.