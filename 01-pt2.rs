use std::fs::File;
use std::io::{self, prelude::*, BufReader};
use std::collections::LinkedList;

fn main() -> io::Result<()> {
    let mut count:u32 = 0;
    let window_size = 3;
    let mut previous_sum:i32 = 0;
    let mut buffer = LinkedList::new();

    // Read out input file and create an iterator
    let file = File::open("01-input.txt")?;
    let reader = BufReader::new(file);
    let mut lines = reader.lines();

    // Prime the sum window
    for _ in 0..window_size {
        let num = lines.next().unwrap().unwrap().parse::<i32>().unwrap();

        buffer.push_back(num);

        previous_sum = buffer.iter().sum::<i32>();
    }

    println!("STR - {:?} - ({} < NULL)", buffer, previous_sum);

    for line in lines {
        let current_number = line?.parse::<i32>().unwrap();

        // Rotate the buffer window
        buffer.push_back(current_number);
        buffer.pop_front();

        // Sum the current window
        let current_sum = buffer.iter().sum::<i32>();

        println!("{} - {:?} - ({} < {})", current_number, buffer, previous_sum, current_sum);

        if previous_sum < current_sum {
            count += 1;
        }

        previous_sum = current_sum.clone();
    }

    println!("num of increases : {}", count);
    Ok(())
}
