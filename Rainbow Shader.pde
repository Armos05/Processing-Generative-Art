class Metaball {
	constructor() {
		const size = Math.pow(Math.random(), 2);
		this.vel = p5.Vector.random2D().mult(8 * (1 - size) + 2);
		this.radius = 100 * size + 20;
		
		this.pos = new p5.Vector(width / 2, height / 2);
	}
	
	update() {
		this.pos.add(this.vel);
		
		if (this.pos.x < this.radius || this.pos.x > width  - this.radius) this.vel.x *= -1;
		if (this.pos.y < this.radius || this.pos.y > height - this.radius) this.vel.y *= -1;
	}
}

function getShader(_renderer) {
	const vert = `
		attribute vec3 aPosition;
		attribute vec2 aTexCoord;

		varying vec2 vTexCoord;

		void main() {
			vTexCoord = aTexCoord;

			vec4 positionVec4 = vec4(aPosition, 1.0);
			positionVec4.xy = positionVec4.xy * 2.0 - 1.0;

			gl_Position = positionVec4;
		}
	`;

	const frag = `
		precision highp float;

		varying vec2 vTexCoord;

		uniform vec3 metaballs[${N_balls}];

		const float WIDTH = ${windowWidth}.0;
		const float HEIGHT = ${windowHeight}.0;

		vec3 hsv2rgb(vec3 c) {
				vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
				vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
				return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
		}

		void main() {
			float x = vTexCoord.x * WIDTH;
			float y = vTexCoord.y * HEIGHT;
			float v = 0.0;

			for (int i = 0; i < ${N_balls}; i++) {
				vec3 ball = metaballs[i];
				float dx = ball.x - x;
				float dy = ball.y - y;
				float r = ball.z;
				v += r * r / (dx * dx + dy * dy);
			}

			if (0.9 < v && v < 1.1) {
				float a = (v - 0.9) * 4.;
				gl_FragColor = vec4(hsv2rgb(vec3(a, 1., 1.)), 1.0);
			} else gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
		}
	`;
	
	return new p5.Shader(_renderer, vert, frag);
}

let metaballShader;

const N_balls = 20,
			metaballs = [];

function preload() {
	metaballShader = getShader(this._renderer);
}

function setup() {
	createCanvas(windowWidth, windowHeight, WEBGL);
	shader(metaballShader);
	
	for (let i = 0; i < N_balls; i ++) metaballs.push(new Metaball());
}

function draw() {
	var data = [];
	
	for (const ball of metaballs) {
		ball.update();
		data.push(ball.pos.x, ball.pos.y, ball.radius);
	}
	
	metaballShader.setUniform("metaballs", data);
	rect(0, 0, width, height);
}

// OpenProcessing has a bug where it always creates a scrollbar on Chromium.
function mouseWheel() { // This stops the canvas from scrolling by a few pixels.
	return false;
}
