pub mod util;

pub fn p1(input: &Vec<String>) -> i32 {
    let coord = navigate(input, false);
    coord.horiz * coord.depth
}

pub fn p2(input: &Vec<String>) -> i32 {
    let coord = navigate(input, true);
    coord.horiz * coord.depth
}

struct Coord {
    horiz: i32,
    depth: i32,
    aim: i32,
}

fn navigate(input: &Vec<String>, consider_aim: bool) -> Coord {
    let mut coord = Coord {
        horiz: 0,
        depth: 0,
        aim: 0,
    };
    for line in input {
        let tokens: Vec<&str> = line.split_whitespace().collect();
        let direction = tokens[0];
        let value: i32 = tokens[1].parse().unwrap();
        match (direction, consider_aim) {
            ("forward", false) => coord.horiz += value,
            ("down", false) => coord.depth += value,
            ("up", false) => coord.depth -= value,
            ("forward", true) => {
                coord.horiz += value;
                coord.depth += value * coord.aim;
            }
            ("down", true) => coord.aim += value,
            ("up", true) => coord.aim -= value,
            _ => {}
        }
    }
    coord
}
