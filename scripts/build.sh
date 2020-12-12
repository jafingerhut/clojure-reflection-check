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

if [ $# -ne 2 ]
then
    1>&2 echo "usage: `basename $0` <clojure-git-tag> <log-dir>"
    exit 1
fi

# This parameter should be a tag name in the Github CLojure source
# tree, i.e. one of the strings output by the command "git tag -l"
# when run inside of a clone of the Clojure source code repository.

# e.g. clojure-1.10.1

CLJ_VERSION="$1"
LOG_DIR="$2"

LOG1="${LOG_DIR}/build-log-${CLJ_VERSION}.txt"
LOG2="${LOG_DIR}/summary-${CLJ_VERSION}.txt"

${INSTALL_DIR}/build2.sh "${CLJ_VERSION}" |& tee "${LOG1}"
${INSTALL_DIR}/analyze-log.sh "${LOG1}" |& tee "${LOG2}"
