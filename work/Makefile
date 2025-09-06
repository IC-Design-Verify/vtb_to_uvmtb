tb_filelist  = -f ../dv/filelist.f
rtl_filelist = -f ../design/filelist.f

all: comp run

comp:
	vcs -kdb -full64 -sverilog -debug_access+r+f \
		-timescale=1ns/1ps \
		-ntb_opts uvm-1.2 \
		$(tb_filelist) \
		$(rtl_filelist) \
		-top tb_top |& tee -i comp.log

run:
	./simv |& tee -i simv.log

verdi:
	verdi -ssf novas.fsdb &

clean:
	rm -rf core.* *log csrc* simv* ucli* verdi* novas* *fsdb vc_hdrs.h
