#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/azra/catkin_ws_kr/src/turtlebot/src/turtlebot_create/create_driver"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/azra/catkin_ws_kr/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/azra/catkin_ws_kr/install/lib/python2.7/dist-packages:/home/azra/catkin_ws_kr/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/azra/catkin_ws_kr/build" \
    "/usr/bin/python" \
    "/home/azra/catkin_ws_kr/src/turtlebot/src/turtlebot_create/create_driver/setup.py" \
    build --build-base "/home/azra/catkin_ws_kr/build/turtlebot/src/turtlebot_create/create_driver" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/azra/catkin_ws_kr/install" --install-scripts="/home/azra/catkin_ws_kr/install/bin"
