# Copyright 2020 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

CORES ?= 2

update-hw:
	./util/gen_clint.py data/clint.hjson.tpl -c ${CORES} > src/clint.hjson
	./util/gen_clint.py data/clint.sv.tpl -c ${CORES} > src/clint.sv
	./util/gen_clint.py data/clint_wrapper.sv.tpl -c ${CORES} > synth/clint_wrapper.sv
	../../../util/regtool.py src/clint.hjson -r --outdir src/
