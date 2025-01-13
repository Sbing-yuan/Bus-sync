TB:
	iverilog TB.v -o TB.o -y ../rtl
	vvp TB.o
	rm TB.o	

GTK:
	export DISPLAY=:0
	gtkwave

VM:
	xemacs --batch $(file) -f verilog-auto-save-compile

VM_TB:
	xemacs --batch TB.v -f verilog-auto-save-compile

