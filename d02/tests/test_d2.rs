use d2;
pub use d2::util;

#[test]
fn p1_solves_the_example() {
    let example = d2::util::readlines("tests/example.txt");
    assert_eq!(150, d2::p1(&example));
}

#[test]
fn p2_solves_the_example() {
    let example = d2::util::readlines("tests/example.txt");
    assert_eq!(900, d2::p2(&example));
}
