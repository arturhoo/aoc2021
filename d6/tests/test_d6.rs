use d6;
pub use d6::util;

#[test]
fn p1_solves_the_example() {
    let example = d6::util::readlines("tests/example.txt");
    assert_eq!(26, d6::p1(&example, 18));
    assert_eq!(5934, d6::p1(&example, 80));
}

#[test]
fn p2_solves_the_example() {
    let example = d6::util::readlines("tests/example.txt");
    assert_eq!(26, d6::p2(&example, 18));
    assert_eq!(5934, d6::p2(&example, 80));
    assert_eq!(26984457539, d6::p2(&example, 256));
}
