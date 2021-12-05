pub mod util;
use std::cmp::max;

#[derive(Debug)]
struct Point {
    x: usize,
    y: usize,
}

#[derive(Debug)]
struct Line {
    p1: Point,
    p2: Point,
}

enum Direction {
    Horizontal,
    Vertical,
    Diagonal,
}

pub fn p1(input: &Vec<String>) -> usize {
    let (lines, width, height) = build_lines(input);
    let mut grid = build_grid(width, height);

    for line in lines {
        mark_line(&mut grid, &line, false);
    }
    calculate_overlaps(&grid)
}

pub fn p2(input: &Vec<String>) -> usize {
    let (lines, width, height) = build_lines(input);
    let mut grid = build_grid(width, height);

    for line in lines {
        mark_line(&mut grid, &line, true);
    }
    calculate_overlaps(&grid)
}

fn build_lines(input: &Vec<String>) -> (Vec<Line>, usize, usize) {
    let (mut max_x, mut max_y) = (0usize, 0usize);
    let mut lines: Vec<Line> = vec![];

    for input_line in input {
        let coords: Vec<&str> = input_line.split("->").map(|token| token.trim()).collect();
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
    (lines, width, height)
}

fn build_grid(width: usize, height: usize) -> Vec<Vec<usize>> {
    let mut grid: Vec<Vec<usize>> = Vec::with_capacity(height);
    for _ in 0..height {
        grid.push(vec![0; width]);
    }
    grid
}

fn mark_line(grid: &mut Vec<Vec<usize>>, line: &Line, consider_diagonal: bool) -> () {
    let direction = if line.p1.x == line.p2.x {
        Direction::Vertical
    } else if line.p1.y == line.p2.y {
        Direction::Horizontal
    } else {
        Direction::Diagonal
    };

    match (direction, consider_diagonal) {
        (Direction::Vertical, _) => {
            let mut extremes = [line.p1.y, line.p2.y];
            extremes.sort();
            for y in extremes[0]..(extremes[1] + 1) {
                grid[y][line.p1.x] += 1;
            }
        }
        (Direction::Horizontal, _) => {
            let mut extremes = [line.p1.x, line.p2.x];
            extremes.sort();
            for x in extremes[0]..(extremes[1] + 1) {
                grid[line.p1.y][x] += 1;
            }
        }
        (Direction::Diagonal, true) => {
            let line_length = (line.p1.x as i32 - line.p2.x as i32).abs() + 1;
            let x_opr: i32 = if line.p2.x > line.p1.x { 1 } else { -1 };
            let y_opr: i32 = if line.p2.y > line.p1.y { 1 } else { -1 };
            let (mut x, mut y) = (line.p1.x as i32, line.p1.y as i32);
            for _ in 0..(line_length) {
                grid[y as usize][x as usize] += 1;
                y += y_opr;
                x += x_opr;
            }
        }
        _ => {}
    };
}

fn calculate_overlaps(grid: &Vec<Vec<usize>>) -> usize {
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
