mod util;

fn main() {
    let input = util::readlines("src/input13.txt");
    println!("{}", d13::p1(&input));
    println!("{}", d13::p2(&input));
}
