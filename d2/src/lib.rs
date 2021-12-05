pub mod util;

pub fn p1(input: &Vec<String>) -> i32 {
    let mut horiz = 0;
    let mut depth = 0;

    for line in input {
        let v: Vec<&str> = line.split_whitespace().collect();
        let value: i32 = v[1].parse().expect("expected integer");
        match v[0] {
            "forward" => horiz += value,
            "down" => depth += value,
            "up" => depth -= value,
            _ => println!("Unexpected input: {}", v[0]),
        }
    }
    horiz * depth
}

pub fn p2(input: &Vec<String>) -> i32 {
    let mut horiz = 0;
    let mut depth = 0;
    let mut aim = 0;

    for line in input {
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
    horiz * depth
}
