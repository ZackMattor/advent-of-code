use std::fs::File;
use std::io::{self, prelude::*, BufReader};

fn main() -> io::Result<()> {
    let mut count:u32 = 0;

    let file = File::open("01-input.txt")?;
    let reader = BufReader::new(file);
    let mut lines = reader.lines();

    // I hate this line...
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
