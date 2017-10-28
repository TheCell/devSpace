<?php
header('Access-Control-Allow-Origin: http://dev.thecell.eu/');
$counter = 0;
$images = json_decode($_POST['images'], true);
foreach($images as $image)
{
	/*
	$image = str_replace("data:image/png;base64,", "", $image);
    $image = base64_decode($image);
    file_put_contents('images/image_' . $counter . '.png', $image);
    $counter ++;
    */
}
echo "images saved";

/*
var imagesArr = [];
images = document.getElementById("tempIcons").childNodes;
for( let i = 0; i < images.length; i++)
{
	if(images[i].nodeType == 1)
	{
		imagesArr.push(images[i].toDataURL());
	}
}

var imagesArrJson = JSON.stringify(imagesArr);
var data = new FormData();
data.append('images', imagesArrJson);
var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {
if (this.readyState == 4 && this.status == 200) {
	console.log(this.responseText);
}
};
xhttp.open("POST", "http://dev.thecell.eu/favcellularautomata/getImages.php", true);
xhttp.send(data);



var returnData = fetch('http://dev.thecell.eu/favcellularautomata/getImages.php',
{
method: 'post',
headers: {
  'Accept': 'application/json',
  'Content-Type': 'application/json'
},
body: {images:JSON.stringify(imagesArr)}
}).then(function(response) {console.log(response);});
*/
?>