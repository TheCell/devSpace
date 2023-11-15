import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 55, window.innerWidth / window.innerHeight, 0.1, 1000 );

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

const controls = new OrbitControls( camera, renderer.domElement );
controls.autoRotate = true;
controls.autoRotateSpeed = 1.0;

const loader = new GLTFLoader();

loader.load('./pascalito/pascalito.glb', function (gltf) {
	console.log('loaded', gltf);
	scene.add(gltf.scene);
	console.log(scene);
}, function (xhr) {
	// console.log('gltf ' + (xhr.loaded / xhr.total * 100) + '% loaded');
}, function (error) {
	console.error(error);
});

const color = 0xFFFFFF;
const intensity = 1;
const light = new THREE.AmbientLight(color, intensity);
scene.add(light);

//controls.update() must be called after any manual changes to the camera's transform
camera.position.set( 3, 1, 0 );
controls.update();

function animate() {
	requestAnimationFrame( animate );
	// required if controls.enableDamping or controls.autoRotate are set to true
	controls.update();
	renderer.render( scene, camera );
	// scene.rotation.y += 0.001;
}

animate();