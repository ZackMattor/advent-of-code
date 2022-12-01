pub struct Diagnostics {
    pub sums : Option<Vec::<u32>>,
    pub line_count : u32
}

impl Diagnostics {
    pub fn new() -> Diagnostics {
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
            let bit = ch == '1';
            self.sums.as_mut().unwrap()[i] += if bit { 1 } else { 0 };
        }

        self.line_count += 1;
    }

    pub fn get_gamma(&self) -> u32 {
        self.map_to_number(self.get_gamma_map())
    }

    pub fn get_epsilon(&self) -> u32 {
        self.map_to_number(self.get_epsilon_map())
    }

    pub fn get_power_consumption(&self) -> u32 {
        self.get_gamma() * self.get_epsilon()
    }

    pub fn map_to_number(&self, map:Vec<bool>) -> u32 {
        map.iter().fold(0, |result, &bit| {
            result << 1 ^ bit as u32
        })
    }

    pub fn get_gamma_map(&self) -> Vec<bool> {
        let sums = self.sums.as_ref().unwrap();

        // If any one of our sums is MOST present,
        // assume that is a `1` in the binary representation.
        sums.iter().map(|&sum| {
            sum >= ( self.line_count - sum )
        }).collect::<Vec<bool>>()
    }

    pub fn get_epsilon_map(&self) -> Vec<bool> {
        let sums = self.sums.as_ref().unwrap();

        // If any one of our sums is LEAST present,
        // assume that is a `1` in the binary representation.
        sums.iter().map(|&sum| {
            sum < ( self.line_count - sum )
        }).collect::<Vec<bool>>()
    }
}
