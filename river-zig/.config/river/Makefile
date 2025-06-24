build:
	zig build-exe main.zig -femit-bin=init

optimize:
	zig build-exe -O ReleaseSafe main.zig -femit-bin=init

apply:
	make build
	./init
