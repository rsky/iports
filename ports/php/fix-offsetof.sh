#!/bin/bash

if [ ! -f Zend/_Offsetof.h ]; then
  cat > Zend/_Offsetof.h <<EOF
#ifndef _Offsetof
#include <stddef.h>
#define _Offsetof(p_type,field) offsetof(p_type,field)
#endif
EOF
  echo >> Zend/zend.h
  echo '#include "_Offsetof.h"' >> Zend/zend.h
fi
