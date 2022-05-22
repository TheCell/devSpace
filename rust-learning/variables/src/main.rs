use std::io;

fn main() {
    let mut x = 5;
    println!("The value of x is: {}", x);
    x = 6;
    println!("The value of x is: {}", x);

    let y = 5;
    let y = y + 1;
    let y = y * 2;
    println!("The calue of y is: {}", y);

    let f = 2.0; // f64
    let ff: f32 = 3.0; // f32
    println!("64 bit {} and 32 bit{}", f, ff);

    // chars are 4 bytes
    let c = 'z';
    let z = 'ℤ';
    let heart_eyed_cat = '😻';
    println!("These are all single characters: {}, {}, {}", c, z, heart_eyed_cat);

    let tuple: (i32, f64, u8) = (500, 6.4, 1);
    let five_hundred = tuple.0;
    let six_point_four = tuple.1;
    let one = tuple.2;
    println!("tuple values: {}, {}, {}", five_hundred, six_point_four, one);

    let array: [i32; 5] = [1, 2, 3, 4, 5]; // the : [i32; 5] is optional
    println!("array length: {}", array.len());

    let filledarray = [3; 5]; // array with 5 entries all initialized with 3
    println!("array length: {}", filledarray.len());

    println!("Please enter an array index.");
    let mut index = String::new();

    io::stdin()
        .read_line(&mut index)
        .expect("Failed to read line");

    let index: usize = index
        .trim()
        .parse()
        .expect("Index entered was not a number");

    let element = array[index];

    println!(
        "The value of the element at index {} is: {}",
        index, element
    );
}
