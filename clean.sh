export OPENCL_DIR="$(readlink -f ROCm-OpenCL-Runtime)"
export ROCclr_DIR="$(readlink -f ROCclr)"
export ROCR_DIR="$(readlink -f ROCR-Runtime)"
export ROCT_DIR="$(readlink -f ROCT-Thunk-Interface)"
export ASSET_DIR="$(readlink -f asset)"

rm -rf ${ROCT_DIR}/build
rm -rf ${ROCR_DIR}/src/build
rm -rf ${ROCclr_DIR}/build
rm -rf ${OPENCL_DIR}/build
rm -rf ${ASSET_DIR}/bin/*
rm -rf ${ASSET_DIR}/lib/*
rm -rf ${ASSET_DIR}/include/*
