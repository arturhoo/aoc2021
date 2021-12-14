use d5;
pub use d5::util;

#[test]
fn p1_solves_the_example() {
    let example = d5::util::readlines("tests/example.txt");
    assert_eq!(5, d5::p1(&example));
}

#[test]
fn p2_solves_the_example() {
    let example = d5::util::readlines("tests/example.txt");
    assert_eq!(12, d5::p2(&example));
}
