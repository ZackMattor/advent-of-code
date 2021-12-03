use std::io;

use crate::common::util;

pub fn run() -> io::Result<()> {
    let mut count:u32 = 0;
    let mut lines = util::read_input("day_01/input.txt");
    let mut previous_number = lines.next().unwrap().unwrap().parse::<i32>().unwrap();

    for line in lines {
        let current_number = line?.parse::<i32>().unwrap();
        println!("num : {} {}", previous_number, current_number);

        if previous_number < current_number {
            count += 1;
        }

        previous_number = current_number.clone();
    }

    println!("num of increases : {}", count);
    Ok(())
}
