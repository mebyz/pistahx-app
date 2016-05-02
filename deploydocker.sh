cd ../pistahx-app_builds
git reset --hard HEAD
cp ../pistahx/distrib/out/* app/
cp ../pistahx/distrib/package.json app/
cp ../pistahx/Dockerfile .
git add *
git commit
git push
