kvm:
	qemu-system-x86_64 \
	-enable-kvm \
	-m 3G \
	-smp 2 \
	-cpu host \
	-hda /sgoinfre/mthetcha/vm-disk.qcow2 \
	-daemonize \
	-netdev user,id=net0,hostfwd=tcp::2222-:22 \
	-device virtio-net-pci,netdev=net0 \
	-monitor tcp:127.0.0.1:4444,server,nowait \

ssh:
	ssh -p 2222 mthetcha@127.0.0.1
