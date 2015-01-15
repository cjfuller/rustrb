require "mkmf"

base_dir = ENV['BASE_DIR']

rustdir = '/usr/local/lib/rustlib/x86_64-apple-darwin/lib'

rust_hash = '4e7c5e5c'

libs = ["libstd", "libcollections", "libunicode", "librand", "liballoc", "librand", "libcore", "liblibc"]

libs_full = libs.map { |l| "#{rustdir}/#{l}-#{rust_hash}.rlib" }
`rustc --emit obj --crate-type dylib -o #{base_dir}/target/rustrb.o #{base_dir}/ext/rustrb/rustrb.rs`

$libs += " -L#{rustdir} -lc -lm -lSystem -lpthread -lcompiler-rt "
$CFLAGS += " -Wl,--verbose"
$LDFLAGS += " -Wl,-force_load,#{rustdir}/libmorestack.a #{libs_full.join(" ")} #{base_dir}/target/rustrb.o"

create_makefile("rustrb")

