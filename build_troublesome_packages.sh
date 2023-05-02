#!/bin/bash

# a number of the packages need to be created locally before being uploaded or they are missing key files
mkdir -p packages
cd ./packages
troublesome_packages=("cpython/3.10.4" "autoconf/2.71" "automake/1.16.5" "boost/1.79.0" "brotli/1.0.9" "bzip2/1.0.8" "clipper/6.4.2" "expat/2.4.1" "fmt/9.0.0" "gperf/3.1" "libffi/3.2.1" "libiconv/1.17" "m4/1.4.19" "openssl/1.1.1l" "pkgconf/1.7.4" "protobuf/3.21.4" "sipbuildtool/0.2.3@ultimaker/stable" "spdlog/1.10.0" "sqlite3/3.36.0" "standardprojectsettings/0.1.0@ultimaker/stable" "uranium/5.3.1-beta.1+10341@ultimaker/stable" "zlib/1.2.12" "libxcrypt/4.4.25" "gdbm/1.19" "ncurses/6.2" "bison/3.7.6")
for package in ${troublesome_packages[@]}; do
    echo $package
    rm -r ./temp || true
    mkdir ./temp
    cd ./temp
    conan remove $package --force || true
    package_contains_at_symbol=$(echo $package|grep -q "@"|echo $?) #exit code will be 0 if at present, else 1
    echo "package contains at $package_contains_at_symbol"
    if [[ package_contains_at_symbol -eq 1 ]]; then
        conan install $package --build=missing
    else
        #conan will not interpret $package as a package if it doesn't contain an @
        #for packages without a @<user>/<chanel> a terminal @ is required
        conan install $package@ --build=missing 
    fi
    cd ..
done
cd ..
rm -r packages