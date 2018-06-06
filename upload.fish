#!/usr/local/bin/fish

set pod_version
grep -E 's.version.*=' AMRouter.podspec


function ask_pod_version
  read -P "Please set pod version:" -s $pod_version
end

# while not test \( string match -q '\d\d{0,1}[.]\d\d{0,1}[.]\d\d{0,1}' $pod_version \)
  # set pod_version
  ask_pod_version
# end

if not set $pod_version
  exit 1
end

git stash
git pull --tags
git stash pop

git all .
git commit -am ":bookmark: upgrade: version to $pod_version"
git tag $pod_version

if [ $status -ne 0 ]
  echo "There has existed a same tag: $pod_version\n Please set the pod.version in AMRouter.podspec"
  exit 1
end

git push --tags
git push

pod trunk push --verbose






