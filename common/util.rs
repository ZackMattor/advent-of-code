use std::fs::File;
use std::io::{prelude::*, BufReader};

pub fn read_input(path: &str) -> std::io::Lines<BufReader<File>> {
    let file = File::open(path).unwrap();
    let reader = BufReader::new(file);

    reader.lines()
}
