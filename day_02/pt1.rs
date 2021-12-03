use std::io;

use crate::common::util;

#[derive(Debug)]
struct Position {
    pub horizontal_pos: i32,
    pub depth: i32,
}

pub fn run() -> io::Result<()> {
    let cmds = util::read_input("day_02/input.txt");
    let mut pos = Position{ horizontal_pos: 0, depth: 0 };

    for cmd in cmds {
        let stuff = cmd.unwrap();
        let mut cmd_parts = stuff.split_whitespace();

        let command = cmd_parts.next().unwrap();
        let value = cmd_parts.next().unwrap().parse::<i32>().unwrap();

        match command.as_ref() {
            "down" => pos.depth += value,
            "up" => pos.depth -= value,
            "forward" => pos.horizontal_pos += value,
            _ => println!("Invalid command! {}", command)
        }
        println!("cmd : {} | {}", command, value);
    }


    println!("");
    println!("Final Position : {:?}", pos);
    println!("Final Answer : {}", pos.horizontal_pos * pos.depth);
    Ok(())
}
