#!/bin/bash

export GIT_WORK_TREE=/var/lib/trac/xbmc/xbmc.git/
export GIT_DIR=/var/lib/trac/xbmc/xbmc.git/.git/
basedir="."

firstrev=$(git svn find-rev $(git rev-list -n 1 $(git for-each-ref --format="%(refname)")))
mkdir -p "${basedir}/$(printf "%02d" $(expr ${firstrev} / 1000))/$(expr ${firstrev} % 1000 / 100)"
git rev-list $(git for-each-ref --format="%(refname)") | while read iter; do
  svnrev=$(git svn find-rev "${iter}")
  dir1=$(printf "%02d" $(expr $svnrev / 1000))
  dir2=$(expr $svnrev % 1000 / 100)
  filename=$(printf "%02d" $(expr $svnrev % 100))
  if [ "${filename}" = "99" ]; then mkdir -p "${basedir}/${dir1}/${dir2}"; fi
  echo "${basedir}/${dir1}/${dir2}/${filename}  -->  ${iter}"
  echo "${iter}" > "${basedir}/${dir1}/${dir2}/${filename}"
done
