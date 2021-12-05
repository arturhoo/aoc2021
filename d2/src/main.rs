mod util;

fn main() {
    let input = util::readlines("src/input2.txt");
    println!("{}", d2::p1(&input));
    println!("{}", d2::p2(&input));
}
