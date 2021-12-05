pub mod util;
use std::cmp::max;

#[derive(Debug)]
struct Point {
    x: usize,
    y: usize,
}

struct Line {
    p1: Point,
    p2: Point,
}

pub fn p1(input: Vec<String>) -> usize {
    let (mut max_x, mut max_y): (usize, usize) = (0, 0);
    let mut lines: Vec<Line> = vec![];

    for line in input {
        let coords: Vec<&str> = line.split("->").map(|token| token.trim()).collect();
        let coord1: Vec<&str> = coords[0].split(",").collect();
        let p1 = Point {
            x: coord1[0].parse().unwrap(),
            y: coord1[1].parse().unwrap(),
        };
        let coord2: Vec<&str> = coords[1].split(",").collect();
        let p2 = Point {
            x: coord2[0].parse().unwrap(),
            y: coord2[1].parse().unwrap(),
        };
        max_x = max(max_x, max(p1.x, p2.x));
        max_y = max(max_y, max(p1.y, p2.y));

        let line = Line { p1: p1, p2: p2 };
        lines.push(line);
    }
    let width: usize = max_x + 1;
    let height: usize = max_y + 1;

    let mut grid: Vec<Vec<i32>> = Vec::with_capacity(height);
    for _ in 0..height {
        grid.push(vec![0; width]);
    }

    for line in lines {
        mark_line(&mut grid, &line);
    }
    calculate_overlaps(&grid)
}

fn mark_line(grid: &mut Vec<Vec<i32>>, line: &Line) -> () {
    let direction = if line.p1.x == line.p2.x {
        "vertical"
    } else if line.p1.y == line.p2.y {
        "horizontal"
    } else {
        "invalid"
    };

    match direction {
        "vertical" => {
            let mut extremes = [line.p1.y, line.p2.y];
            extremes.sort();
            for y in extremes[0]..(extremes[1] + 1) {
                grid[y][line.p1.x] += 1;
            }
        }
        "horizontal" => {
            let mut extremes = [line.p1.x, line.p2.x];
            extremes.sort();
            for x in extremes[0]..(extremes[1] + 1) {
                grid[line.p1.y][x] += 1;
            }
        }
        _ => {}
    };
}

fn calculate_overlaps(grid: &Vec<Vec<i32>>) -> usize {
    let mut cnt: usize = 0;
    for y in 0..grid.len() {
        for x in 0..grid[0].len() {
            if grid[y][x] >= 2 {
                cnt += 1;
            }
        }
    }
    cnt
}
