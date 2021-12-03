use std::io;

use crate::common::util;

struct Diag {
    pub sums : Option<Vec::<i32>>,
    pub line_count : u16
}

impl Diag {
    pub fn new() -> Diag {
        Self {
            sums: None,
            line_count: 0,
        }
    }

    pub fn ingest(&mut self, input:&String) {
        // Initialize sums to the length of the diag input
        if self.sums.is_none() {
            self.sums = Some(vec![0; input.len()])
        }

        for (i, ch) in input.chars().enumerate() {
            self.sums.as_mut().unwrap()[i] += if ch == '1' { 1 } else { 0 };
        }

        self.line_count += 1;
    }

    pub fn getGamma(&self) -> u32 {
        let sums = self.sums.as_ref().unwrap();

        // If any one of our sums is most present,
        // assume that is a `1` in the binary representation.
        sums.iter().fold(0, |result, &sum| {
            result << 1 ^ if sum > ( self.line_count/2 ).into() { 1 } else { 0 }
        })
    }

    pub fn getEpsilon(&self) -> u32 {
        let sums = self.sums.as_ref().unwrap();

        // If any one of our sums is most present,
        // assume that is a `1` in the binary representation.
        sums.iter().fold(0, |result, &sum| {
            result << 1 ^ if sum < ( self.line_count/2 ).into() { 1 } else { 0 }
        })
    }

    pub fn getPowerConsumption(&self) -> u32 {
        self.getGamma() * self.getEpsilon()
    }
}

pub fn run() -> io::Result<()> {
    let lines = util::read_input("day_03/input.txt");

    let mut diag = Diag::new();

    for line in lines {
        let diag_line = line.unwrap();

        diag.ingest(&diag_line)
    }

    println!("");
    println!("Gamma : {:?}", diag.getGamma());
    println!("Epsilon : {:?}", diag.getEpsilon());
    println!("Power Consumption : {:?}", diag.getPowerConsumption());

    Ok(())
}
