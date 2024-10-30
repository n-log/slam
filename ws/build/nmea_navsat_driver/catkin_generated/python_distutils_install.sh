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
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/xlqmu/ws/src/RMUC24_real/sensor_interface/nmea_navsat_driver"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/xlqmu/ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/xlqmu/ws/install/lib/python3/dist-packages:/home/xlqmu/ws/build/nmea_navsat_driver/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/xlqmu/ws/build/nmea_navsat_driver" \
    "/usr/bin/python3" \
    "/home/xlqmu/ws/src/RMUC24_real/sensor_interface/nmea_navsat_driver/setup.py" \
     \
    build --build-base "/home/xlqmu/ws/build/nmea_navsat_driver" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/xlqmu/ws/install" --install-scripts="/home/xlqmu/ws/install/bin"
