use std::fs::File;
use std::io::BufRead;
use std::io::BufReader;

pub fn readlines(filename: &str) -> Vec<String> {
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);
    reader
        .lines()
        .map(|l| l.unwrap().trim().to_string())
        .collect()
}
