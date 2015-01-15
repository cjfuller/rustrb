extern crate libc;
use libc::{c_char, c_int};

pub type VALUE = u64;

extern {
    fn rb_define_class(name: *const c_char, supercls: VALUE) -> VALUE;
    fn rb_define_method(klass: VALUE, name: *const c_char, func: extern fn() -> VALUE, argc: c_int) -> ();
    static rb_cObject: VALUE;
}

#[no_mangle]
pub extern "C" fn Init_rustrb() -> () {
    use rb::defclass;
    defclass(String::from_str("Test"));
}

#[no_mangle]
pub extern "C" fn test_fn() -> VALUE {
    println!("Hello, world!");
    0
}

mod rb {

    pub fn defclass(name: String) -> () {
        let c_name = name.as_bytes().as_ptr();
        unsafe {
            let cl = ::rb_define_class(c_name as *const i8, ::rb_cObject);
            ::rb_define_method(cl, String::from_str("testmethod").as_bytes().as_ptr() as *const i8,
                               ::test_fn, 0);
        }
    }

}
