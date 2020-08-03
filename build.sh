sudo apt-get install rock-dkms comgr 
sudo usermod -a -G video $LOGNAME
export OPENCL_DIR="$(readlink -f ROCm-OpenCL-Runtime)"
export ROCclr_DIR="$(readlink -f ROCclr)"
export ROCR_DIR="$(readlink -f ROCR-Runtime)"
export ROCT_DIR="$(readlink -f ROCT-Thunk-Interface)"
export ASSET_DIR="$(readlink -f asset)"
HOME=`pwd`
cd ${OPENCL_DIR}
sudo cp config/amdocl64.icd /etc/OpenCL/vendors
cd - 
cd ${ROCT_DIR}
mkdir build && cd build
cmake ..
make -j4
cd ${ROCR_DIR}/src
mkdir build && cd build
cmake -DHSAKMT_INC_PATH:STRING="${ROCT_DIR}/include" -DHSAKMT_LIB_PATH:STRING="${ROCT_DIR}/build" ..
make -j4
cd ${ROCclr_DIR}/
mkdir build && cd build
cmake -DOPENCL_DIR="$OPENCL_DIR" ..
make -j4
cd ${OPENCL_DIR}
sudo cp config/amdocl64.icd /etc/OpenCL/vendors
mkdir build && cd build
cmake -DUSE_COMGR_LIBRARY=ON -DCMAKE_PREFIX_PATH="$ROCclr_DIR/build" ..
export CPLUS_INCLUDE_PATH=${ROCclr_DIR}:${ROCclr_DIR}/include:${ROCclr_DIR}/compiler/lib:${ROCclr_DIR}/compiler/lib/include:$CPLUS_INCLUDE_PATH
make -j4
cd ${ASSET_DIR}
cp ${OPENCL_DIR}/build/bin/* ./bin/
cp -r ${OPENCL_DIR}/khronos/headers/opencl2.2/CL ./include/
cp ${OPENCL_DIR}/build/lib/* ./lib/
cp ${OPENCL_DIR}/build/khronos/icd/libOpenCL.so.1.2 ./lib/
cp ${ROCR_DIR}/src/build/libhsa-runtime64.so.1.1.9 ./lib/
cp ${ROCT_DIR}/build/libhsakmt.so.1.0.6 ./lib/
cd lib/
ln -s libOpenCL.so.1.2 libOpenCL.so.1
ln -s libOpenCL.so.1 libOpenCL.so
ln -s libhsa-runtime64.so.1.1.9 libhsa-runtime64.so.1
ln -s libhsa-runtime64.so.1 libhsa-runtime64.so
ln -s libhsakmt.so.1.0.6 libhsakmt.so.1
ln -s libhsakmt.so.1 libhsakmt.so
cd $HOME

