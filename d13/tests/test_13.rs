use d13;
pub use d13::util;

#[test]
fn p1_solves_the_example() {
    let example = d13::util::readlines("tests/example.txt");
    assert_eq!(17, d13::p1(&example));
}

#[test]
fn p2_solves_the_example() {
    let example = d13::util::readlines("tests/example.txt");
    assert_eq!(16, d13::p2(&example));
}
