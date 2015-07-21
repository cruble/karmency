var camera, scene, renderer, coinMesh, targetRotation;

// add vertical axis
var axis = new THREE.Vector3(0,0,0);
var axisGeometry = new THREE.Geometry();
axisGeometry.vertices.push(new THREE.Vector3(0, -1000, 0));
axisGeometry.vertices.push(new THREE.Vector3(0, 1000, 0));
var axisMaterial = new THREE.LineBasicMaterial({
    color: 0xffffff
});
var axisMesh = new THREE.Mesh(axisGeometry, axisMaterial);

var targetRotation = 0;
var targetRotationOnMouseDown = 0;

var mouseX = 0;
var mouseXOnMouseDown = 0;

var windowHalfX = window.innerWidth / 2;
var windowHalfY = window.innerHeight / 2;

function setup() {

    var W = window.innerWidth,
        H = window.innerHeight;
    renderer = new THREE.WebGLRenderer({alpha: true});
    renderer.MapEnabled = true;
    renderer.setClearColor(0xffffff,1);
    renderer.setSize(W, H);
    document.body.appendChild(renderer.domElement);

    camera = new THREE.PerspectiveCamera(125, W / H, 1, 10000);
    camera.position.z = 25;
    camera.position.x = 0;
    camera.position.y = 0;

    scene = new THREE.Scene();
    scene.add(axisMesh);

    var light = new THREE.SpotLight(0xffffff);
    light.position.set(-70,50,75);
    // light.shadowCameraVisible = true;
    // light.castShadow = true;
    scene.add(light);

    // import STL of coin
    var loader = new THREE.STLLoader();

    // generate hex code geometry
    var textGeom = new THREE.TextGeometry("3425", {
        size: 7,
        height: 2.4,
        font: 'helvetiker',
        weight: 'bold'
    });
    textGeom.applyMatrix( new THREE.Matrix4().makeTranslation(-12, -6, 0.1) );

    // generate date geometry
    var dateGeom = new THREE.TextGeometry("06 30 15", {
        size: 3,
        height: 2.4,
        font: 'helvetiker',
        weight: 'bold'
    });
    dateGeom.applyMatrix( new THREE.Matrix4().makeTranslation(-8.25, 3, 0.1) );

    loader.load( '/stl/karma-coins_center.stl', function ( bufferGeometry ) {
        var geometry = new THREE.Geometry().fromBufferGeometry( bufferGeometry );
        // merge geometries
        geometry.merge( textGeom );
        geometry.merge( dateGeom );

        var material = new THREE.MeshPhongMaterial({
            color: 0x0000ff,
            specular: 0x000044,
            shininess: 200
        });

        // adjust merged coin
        geometry.applyMatrix( new THREE.Matrix4().makeTranslation(0, 0, -0.75) );

        // set coinMesh
        coinMesh = new THREE.Mesh( geometry , material);
        scene.add( coinMesh );

        // save the scene as a new STL
        saveSTL( scene, 'karmency' );
    });

    document.addEventListener( 'mousedown', onDocumentMouseDown, false );

}

// add event handlers for mouse control
function onWindowResize() {

    windowHalfX = window.innerWidth / 2;
    windowHalfY = window.innerHeight / 2;

    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();

    renderer.setSize( window.innerWidth, window.innerHeight );

}

function onDocumentMouseDown( event ) {

    event.preventDefault();

    document.addEventListener( 'mousemove', onDocumentMouseMove, false );
    document.addEventListener( 'mouseup', onDocumentMouseUp, false );
    document.addEventListener( 'mouseout', onDocumentMouseOut, false );

    mouseXOnMouseDown = event.clientX - windowHalfX;
    targetRotationOnMouseDown = targetRotation;

}

function onDocumentMouseMove( event ) {

    mouseX = event.clientX - windowHalfX;

    targetRotation = targetRotationOnMouseDown + ( mouseX - mouseXOnMouseDown ) * 0.02;

}

function onDocumentMouseUp( event ) {

    document.removeEventListener( 'mousemove', onDocumentMouseMove, false );
    document.removeEventListener( 'mouseup', onDocumentMouseUp, false );
    document.removeEventListener( 'mouseout', onDocumentMouseOut, false );

}

function onDocumentMouseOut( event ) {

    document.removeEventListener( 'mousemove', onDocumentMouseMove, false );
    document.removeEventListener( 'mouseup', onDocumentMouseUp, false );
    document.removeEventListener( 'mouseout', onDocumentMouseOut, false );

}

function animate() {

    requestAnimationFrame( animate );
    render();

}

function render() {

    renderer.render( scene, camera );

}

setup();
animate();
