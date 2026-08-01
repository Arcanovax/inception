kvm:
	qemu-system-x86_64 \
	-enable-kvm \
	-m 3G \
	-smp 2 \
	-cpu host \
	-hda /sgoinfre/mthetcha/vm-disk.qcow2 \
	-daemonize \
	-monitor tcp:127.0.0.1:4444,server,nowait \

