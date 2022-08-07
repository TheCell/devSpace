use std::env;
use image::io::Reader as ImageReader;
use image::imageops as ImageOperations;

fn main() {
    let path = env::current_dir().unwrap();
    println!("The current directory is {}", path.display());

    let image = read_image();
    println!("Hello, world!");
    let resized = resize(image);
    resized.save("RespawnBox_3_resized.png").unwrap();
}

fn read_image() -> image::DynamicImage {
    let img = ImageReader::open("RespawnBox_3.png").unwrap().decode().unwrap();
    println!("width: {}, height: {}", img.width(), img.height());
    img
}

fn resize(image: image::DynamicImage) -> image::ImageBuffer<image::Rgba<u8>, std::vec::Vec<u8>> {
    println!("resize");
    println!("before: {}", image.width());
    let new_image = ImageOperations::resize(&image, 50, 50, ImageOperations::FilterType::Nearest);
    println!("after: {}", new_image.width());
    new_image
}