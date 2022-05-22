fn main() {
    let mut s1 = String::from("hello");

    let len = calculate_length(&s1);

    println!("The length of '{}' is {}.", s1, len);
    change(&mut s1);
}

fn calculate_length(s: &String) -> usize {
    s.len()
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}

// big problem, s is dropped after the function scope ends
// fn dangle() -> &String {
//     let s = String::from("hello");
//     &s
// }

// this works because we transfer the ownership
// fn no_dangle() -> String {
//     let s = String::from("hello");
//     s
// }