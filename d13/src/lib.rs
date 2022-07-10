use std::cmp::max;
use std::collections::HashSet;
pub mod util;

pub fn p1(input: &Vec<String>) -> usize {
    let (points, folds, edge) = parse_input(input);
    let (new_points, _new_edge) = perform_fold(points, &folds[0], edge);
    new_points.len()
}

pub fn p2(input: &Vec<String>) -> usize {
    let (mut points, folds, mut edge) = parse_input(input);
    for fold in folds {
        let (new_points, new_edge) = perform_fold(points, &fold, edge);
        points = new_points;
        edge = new_edge;
    }
    print_points(&points, &edge);
    points.len()
}

#[derive(Debug, PartialEq, Eq, Hash)]
struct Point {
    x: usize,
    y: usize,
}

#[derive(Debug, PartialEq, Eq, Hash)]
enum Direction {
    Vertical,
    Horizontal,
}

#[derive(Debug, PartialEq, Eq, Hash)]
struct Fold {
    direction: Direction,
    coord: usize,
}

fn parse_input(input: &Vec<String>) -> (HashSet<Point>, Vec<Fold>, Point) {
    let mut points: HashSet<Point> = HashSet::new();
    let mut folds: Vec<Fold> = vec![];
    let (mut max_x, mut max_y) = (0usize, 0usize);

    for line in input {
        if line.is_empty() {
            continue;
        }

        match &line[..3] {
            "fol" => {
                let tokens: Vec<&str> = line.split(' ').collect();
                let fold_tokens: Vec<&str> = tokens[2].split('=').collect();
                let direction = match fold_tokens[0] {
                    "x" => Direction::Vertical,
                    "y" => Direction::Horizontal,
                    _ => unreachable!(),
                };
                let coord: usize = fold_tokens[1].parse().unwrap();
                let fold = Fold { direction, coord };
                folds.push(fold);
            }
            _ => {
                let coords: Vec<&str> = line.split(',').collect();
                let point = Point {
                    x: coords[0].parse().unwrap(),
                    y: coords[1].parse().unwrap(),
                };
                max_x = max(max_x, point.x);
                max_y = max(max_y, point.y);
                points.insert(point);
            }
        }
    }
    let edge = Point { x: max_x, y: max_y };
    (points, folds, edge)
}

fn perform_fold(points: HashSet<Point>, fold: &Fold, edge: Point) -> (HashSet<Point>, Point) {
    let mut new_points: HashSet<Point> = HashSet::new();
    let new_edge: Point = match fold.direction {
        Direction::Vertical => {
            for point in points {
                if point.x > fold.coord {
                    new_points.insert(Point {
                        x: edge.x - point.x,
                        y: point.y,
                    });
                } else {
                    new_points.insert(point);
                }
            }
            Point {
                x: edge.x / 2 - 1,
                y: edge.y,
            }
        }
        Direction::Horizontal => {
            for point in points {
                if point.y > fold.coord {
                    new_points.insert(Point {
                        x: point.x,
                        y: edge.y - point.y,
                    });
                } else {
                    new_points.insert(point);
                }
            }
            Point {
                x: edge.x,
                y: edge.y / 2 - 1,
            }
        }
    };
    (new_points, new_edge)
}

fn print_points(points: &HashSet<Point>, edge: &Point) {
    for y in 0..(edge.y + 1) {
        for x in 0..(edge.x + 1) {
            if points.contains(&Point { x, y }) {
                print!("#");
            } else {
                print!(".");
            }
        }
        println!();
    }
}
