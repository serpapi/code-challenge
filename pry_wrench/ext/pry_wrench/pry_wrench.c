#include "pry_wrench.h"

VALUE rb_mPryWrench;

void
Init_pry_wrench(void)
{
  rb_mPryWrench = rb_define_module("PryWrench");
}
