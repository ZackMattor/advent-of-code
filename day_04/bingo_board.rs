pub struct BingoBoard {
    pub numbers: Vec<u16>,
    pub selected: Vec<bool>,
    pub last_number: u16,
}

impl BingoBoard {
    pub fn new() -> BingoBoard {
        BingoBoard {
            numbers: vec![],
            selected: vec![false; 25],
            last_number: 0,
        }
    }

    pub fn ingest_board(&mut self, other: &mut Vec<u16>) {
        self.numbers.append(other);
    }

    // returns true if board is now winning
    pub fn ingest_called_number(&mut self, called_number:u16) -> bool {
        for y in 0..self.numbers.len() {
            self.selected[y] |= self.numbers[y] == called_number;
            self.last_number = called_number;
        }

        self.is_winner()
    }

    pub fn is_winner(&self) -> bool {
        let ranges = [
            [ 0,1,2,3,4 ],
            [ 5,6,7,8,9 ],
            [ 10,11,12,13,14 ],
            [ 15,16,17,18,19 ],
            [ 20,21,22,23,24 ],
            [ 0,5,10,15, 20 ],
            [ 1,6,11,16, 21 ],
            [ 2,7,12,17, 22 ],
            [ 3,8,13,18, 23 ],
            [ 4,9,14,19, 24 ],
        ];

        let mut winner = false;

        for range in ranges {
            if range.iter().all(|i| self.selected[*i]) {
                winner = true;
                break;
            }
        }

        winner
    }

    pub fn calculate_score(&self) -> u16 {
        let mut score:u16 = 0;

        for (selected, value) in self.selected.iter().zip(self.numbers.iter()) {
            if !selected {
                score += value;
            }
        }

        score * self.last_number
    }
}
