cd builds/win32/ffmpeg_git
git_version=`git rev-parse HEAD`
echo $git_version
cd ../../..
mkdir -p distros
dir="distros/ffmpeg-distro-static-$git_version"
mkdir "$dir"
cp ./builds/win32/ffmpeg_git/ffmpeg.exe "$dir/ffmpeg-32.exe"
cp ./builds/x86_64/ffmpeg_git/ffmpeg.exe "$dir/ffmpeg-x86_64.exe"
7zr a "distros/$dir.7z" "$dir/*"
