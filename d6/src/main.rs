mod util;

fn main() {
    let input = util::readlines("src/input6.txt");
    println!("{}", d6::p1(&input, 80));
    println!("{}", d6::p2(&input, 256));
}
