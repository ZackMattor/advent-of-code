use std::io;

use crate::day_03::diagnostics::Diagnostics;
use crate::common::util;

enum RatingKind {
    OxygenGenerator,
    Co2Scrubber
}

pub fn run() -> io::Result<()> {
    let lines = util::read_input("day_03/input.txt");
    let debug_lines = lines.map(|line| line.unwrap() ).collect::<Vec<_>>();
    let bit_len = ( debug_lines[0].len()-1 ) as u16;

    let oxygen_generator_rating = get_rating(RatingKind::OxygenGenerator, &debug_lines, bit_len, bit_len);
    let co2_scrubber_rating = get_rating(RatingKind::Co2Scrubber, &debug_lines, bit_len, bit_len);

    println!("oxygen_generator_rating : {}", oxygen_generator_rating);
    println!("co2_scrubber_rating : {}", co2_scrubber_rating);
    println!("life support rating : {}", co2_scrubber_rating * oxygen_generator_rating);

    Ok(())
}

fn get_rating(rating_kind: RatingKind, diag_data: &Vec<String>, pos:u16, bit_len:u16) -> u32 {
    let mut diag = Diagnostics::new();

    for line in diag_data {
        diag.ingest(&line)
    }

    // The bit map for the epsilon value
    let gamma_map = match rating_kind {
        RatingKind::OxygenGenerator => diag.get_gamma_map(),
        RatingKind::Co2Scrubber => diag.get_epsilon_map(),
    };

    // This is what we want the bit at `pos` to match
    let gamma_bit = gamma_map[( bit_len-pos ) as usize];
    println!("position : {:?}", pos);
    println!("gamma_map : {:?}", gamma_map);
    println!("gamma bit : {:?}", gamma_bit);

    let filtered = diag_data.iter().filter(|line| {
        let num = u32::from_str_radix(line, 2).unwrap();
        println!("filtering... : {} {:?} {}", line, ((num & (1 << pos)) != 0), gamma_bit);

        ((num & (1 << pos)) != 0) == gamma_bit
    });

    let res_vec = filtered.map(|line| line.clone() ).collect::<Vec<_>>();

    for line in res_vec.clone() {
        println!("{}", line)
    }

    println!("-----");

    if res_vec.len() != 1 {
        println!("round we go");
        get_rating(rating_kind, &res_vec, pos- 1, bit_len)
    } else {
        u32::from_str_radix(res_vec[0].as_str(), 2).unwrap()
    }
}

