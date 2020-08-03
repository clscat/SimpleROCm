bash build.sh
echo "export LD_LIBRARY_PATH=`pwd`/asset/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PATH=`pwd`/asset/bin:$PATH" >> ~/.bashrc
source ~/.bashrc
clinfo
