use std::io;

mod day_01;
mod common;

fn main() -> io::Result<()> {
    let selection = std::env::args().nth(1).expect("no pattern given");

    match selection.as_ref() {
        "0101" => day_01::pt1::run(),
        "0102" => day_01::pt2::run(),
        _ => {
            println!("Not a valid selection : {}", selection);
            Ok(())
        }
    }
}
