#include <ATen/native/mps/OperationUtils.h>

#define TORCH_ASSERT_NO_OPERATORS
#include <ATen/native/UnaryOps.h>

#include <ATen/native/TensorIterator.h>

namespace at::native {
#ifndef PYTORCH_JIT_COMPILE_SHADERS
static auto& lib = mps::MetalShaderLibrary::getBundledLibrary();
#else
#include <ATen/native/mps/SpecialOps_metallib.h>
#endif

static void i0_kernel_mps(TensorIteratorBase& iter) {
  lib.exec_unary_kernel(iter, "i0");
}

static void i0e_kernel_mps(TensorIteratorBase& iter) {
  lib.exec_unary_kernel(iter, "i0e");
}

static void i1_kernel_mps(TensorIteratorBase& iter) {
  lib.exec_unary_kernel(iter, "i1");
}

static void spherical_bessel_j0_kernel_mps(TensorIteratorBase& iter) {
  lib.exec_unary_kernel(iter, "spherical_bessel_j0");
}

static void entr_kernel_mps(TensorIteratorBase& iter) {
  lib.exec_unary_kernel(iter, "entr");
}

REGISTER_DISPATCH(i0_stub, &i0_kernel_mps)
REGISTER_DISPATCH(special_i0e_stub, &i0e_kernel_mps)
REGISTER_DISPATCH(special_i1_stub, &i1_kernel_mps)
REGISTER_DISPATCH(special_spherical_bessel_j0_stub, &spherical_bessel_j0_kernel_mps)
REGISTER_DISPATCH(special_entr_stub, &entr_kernel_mps)
} // namespace at::native
