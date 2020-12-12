#! /bin/bash

# I found this bit of trickery at the StackOverflow link below.  I
# have tested that if the script is referenced through a symbolic link
# (1 level of linking testd), it gets the directory where the symbolic
# link is, not the directory where the linked-to file is located.  I
# believe that is what we want if this script is checked out as a
# linked tree: the directory of the checked-out version, which might
# have changes to other files in the checked-out tree in that same
# directory, and we want to see those.
# http://stackoverflow.com/questions/421772/how-can-a-bash-script-know-the-directory-it-is-installed-in-when-it-is-sourced-w

INSTALL_DIR=$(dirname $(readlink -f "$BASH_SOURCE"))
PATCH_DIR="${INSTALL_DIR}/../patches/all-files-warn-on-reflection"

if [ $# -ne 1 ]
then
    1>&2 echo "usage: `basename $0` <clojure-git-tag>"
    exit 1
fi

# This parameter should be a tag name in the Github CLojure source
# tree, i.e. one of the strings output by the command "git tag -l"
# when run inside of a clone of the Clojure source code repository.

# e.g. clojure-1.10.1

CLJ_VERSION="$1"


# Show versions of everything relevant to the build

echo "VERSION INFO BEGIN"
set -ex
uname -a
lsb_release -a
java -version
mvn -version
echo "VERSION INFO END"

if [ ! -d clojure ]
then
    git clone https://github.com/clojure/clojure
fi

cp -pr clojure "${CLJ_VERSION}"
cd "${CLJ_VERSION}"

git checkout "${CLJ_VERSION}"
patch -p1 < "${PATCH_DIR}/${CLJ_VERSION}.patch"
# Check to see if any .clj files do NOT have any occurrences of:
#     (set! *warn-on-reflection* true)
# All of them should.
set +ex
echo "Clojure source files in src/clj/clojure, or subdirectories, with"
echo "0 occurrences of (set! *warn-on-reflection* true):"
echo "----------------------------------------------------------------------"
find src/clj/clojure -name '*.clj' | xargs grep -c '(set! \*warn-on-reflection\* true)' | grep ':0$'
echo "----------------------------------------------------------------------"
set -ex

mvn clean
mvn install
EXIT_STATUS=$?

set +ex
echo "mvn install exit status: ${EXIT_STATUS}"
