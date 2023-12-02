use std::io;
use crate::common::util;
use crate::day_04::bingo_board::BingoBoard;

pub fn run() -> io::Result<()> {
    let mut lines = util::read_input("day_04/input.txt");
    let mut boards : Vec<BingoBoard> = vec![];
    let mut winner:Option<usize> = None;

    // Ingest all of the input for the called numbers
    let called_numbers: Vec<_> = lines.next().unwrap().unwrap()
                                    .split(",")
                                    .map(|a| a.parse::<u16>().unwrap())
                                    .collect();

    // Ingest all of the input for the boards
    for line in lines {
        let line = line.unwrap();

        match line.as_str() {
            "" => boards.push(BingoBoard::new()),
            _ => {
                // split up each board number string and convert to u16
                let mut next: Vec<u16> = line.split_whitespace()
                                             .map(|a| a.parse::<u16>().unwrap())
                                             .collect();

                boards.last_mut().unwrap().ingest_board(&mut next);
            }
        }
    }

    // Call each number one at a time
    for called_number in called_numbers {
        for i in 0..boards.len() {

            // Have each board ingest its number, and break out if won
            if boards[i].ingest_called_number(called_number) {
                winner = Some(i);
                break;
            }
        }

        if winner.is_some() { break; }
    }

    // Print out the winner!
    if let Some(i) = winner {
        println!("----");
        println!("Board ID {} won! With the number {}", i, boards[i].last_number);
        println!("Score : {:?}", &boards[i].calculate_score());
    } else {
        println!("Noone has won!");
    }

    Ok(())
}
