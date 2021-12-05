mod util;

fn main() {
    let input = util::readlines("src/input5.txt");
    println!("{:?}", d5::p1(input));
}
