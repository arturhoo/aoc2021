use std::{
    fs::File,
    io::{BufRead, BufReader},
};

fn get_reader() -> BufReader<File> {
    let filename = "src/input2.txt";
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);
    return reader;
}

fn calc_pos_simple() -> (i32, i32) {
    let reader = get_reader();
    let mut horiz = 0;
    let mut depth = 0;

    for line in reader.lines().map(|l| l.unwrap().trim().to_string()) {
        let v: Vec<&str> = line.split_whitespace().collect();
        let value: i32 = v[1].parse().expect("expected integer");
        match v[0] {
            "forward" => horiz += value,
            "down" => depth += value,
            "up" => depth -= value,
            _ => println!("Unexpected input: {}", v[0]),
        }
    }
    (horiz, depth)
}

fn calc_pos_aim() -> (i32, i32, i32) {
    let reader = get_reader();
    let mut horiz = 0;
    let mut depth = 0;
    let mut aim = 0;

    for line in reader.lines().map(|l| l.unwrap().trim().to_string()) {
        let v: Vec<&str> = line.split_whitespace().collect();
        let value: i32 = v[1].parse().expect("expected integer");
        match v[0] {
            "forward" => {
                horiz += value;
                depth += value * aim;
            }
            "down" => aim += value,
            "up" => aim -= value,
            _ => println!("Unexpected input: {}", v[0]),
        }
    }
    (horiz, depth, aim)
}

fn main() {
    let (horiz, depth) = calc_pos_simple();
    println!("{}", horiz * depth);

    let (horiz, depth, _aim) = calc_pos_aim();
    println!("{}", horiz * depth);
}
