use std::io;
use crate::common::util;

pub fn run() -> io::Result<()> {
    let mut lines = util::read_input("day_05/input_test.txt");
    let map = vec![vec![0;1000];1000];

    println!("HERE WE GO");

    let val: Vec<_> = lines.map ( |line| {
        let l = line.unwrap();
        println!("{:?}", &l);
        let parts: Vec<_> = l.split("->").map ( |part| {
            println!("{:?}", &part);
            "".to_string()
        }).collect();
        l
    }).collect();

    Ok(())
}
