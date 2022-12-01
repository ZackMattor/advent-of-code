use std::io;

use crate::day_03::diagnostics::Diagnostics;
use crate::common::util;

pub fn run() -> io::Result<()> {
    let lines = util::read_input("day_03/input.txt");

    let mut diag = Diagnostics::new();

    for line in lines {
        let diag_line = line.unwrap();

        diag.ingest(&diag_line)
    }

    println!("");
    println!("Gamma : {:?}", diag.get_gamma());
    println!("Epsilon : {:?}", diag.get_epsilon());
    println!("Power Consumption : {:?}", diag.get_power_consumption());

    Ok(())
}
