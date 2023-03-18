let palette;
let global_n = 0;
function setup() {
  createCanvas(800, 800);
  colorMode(HSB, 360, 100, 100, 100);
  angleMode(DEGREES);
  palette = shuffle(random(colorScheme).colors.concat());
}

function draw() {
  background(0, 0, 95);

  drawingContext.shadowColor = color(0, 0, 0, 10);
  drawingContext.shadowBlur = width / 15;

  drawingContext.globalAlpha = 1;
  // blendMode(BURN);
  for (let i = 0; i < 10; i++) {
    // drawingContext.filter = "blur(" + (10-i)/3 + "px)";
    let r = 350;
    let angle = random(360);
    let rStep = random([ 15, 30, 45, 90]);
    while (r > 100) {
      angleStep = random([5, 15, 30, 45, 60, 90]);
      hollowedOutArc(
        width / 2,
        height / 2,
        min(r, 800),
        max(0, r - rStep),
        angle,
        angle + angleStep,
        random() > 0.25,
        1
      );
      angle += angleStep;
      r -= random() < 0.5 ? (rStep * 1) / 2 : 0;
    }
  }
  noLoop();
}

function hollowedOutArc(
  x,
  y,
  maxD,
  minD,
  startAngle,
  endAngle,
  bool,
  angleStep = 1
) {
  push();
  translate(x, y);
  let colors = shuffle(palette.concat());
  let gradient;
  let c1 = color(colors[1]);
  // c1.setAlpha(0);
  // if (random() > 0.5) {
  //   gradient = drawingContext.createConicGradient(radians(startAngle), 0, 0);
  //   gradient.addColorStop(0, colors[0]);
  //   gradient.addColorStop((endAngle - startAngle) / 360/2, colors[2]);
  //   gradient.addColorStop((endAngle - startAngle) / 360, c1);
  // } else {
  //   gradient = drawingContext.createRadialGradient(0, 0, minD, 0, 0, maxD);
  //   gradient.addColorStop(0, colors[0]);
  //   gradient.addColorStop(1/2, colors[2]);
  //   gradient.addColorStop(1, c1);
  // }
  global_n %2==0?fill(0,0,15):fill(0,0,90);
  global_n++ %2==0?stroke(0,0,90):stroke(0,0,15);
  // drawingContext.fillStyle = gradient;
  // fill(random(palette));

  if (bool) {
    if (random() > 0.75) {
      let angle = startAngle;
      let angle_plus = (endAngle - startAngle) / int(random(1, 15));
      while (angle < endAngle) {
        hollowedOutArc(
          0,
          0,
          maxD,
          minD,
          angle+1,
          angle + angle_plus-1,
          false,
          (angleStep = 1)
        );
        angle += angle_plus;
      }
    } else {
      let d = minD;
      let d_plus = max(10,(maxD - minD) / int(random(1, 15)));
      while (d < maxD) {
        hollowedOutArc(0, 0, d+2, d+d_plus-2, startAngle, endAngle, false, 1);
        d += d_plus;
      }
    }
  }else{
  beginShape();
  for (let a = startAngle; a <= endAngle; a += angleStep) {
    vertex(cos(a) * maxD, sin(a) * maxD);
  }
  for (let a = endAngle; a >= startAngle; a -= angleStep) {
    vertex(cos(a) * minD, sin(a) * minD);
  }
  endShape(CLOSE);
  }

  pop();
}

let colorScheme = [
  {
    name: "Benedictus",
    colors: ["#F27EA9", "#366CD9", "#5EADF2", "#636E73", "#F2E6D8"],
  },
  {
    name: "Cross",
    colors: ["#D962AF", "#58A6A6", "#8AA66F", "#F29F05", "#F26D6D"],
  },
  {
    name: "Demuth",
    colors: ["#222940", "#D98E04", "#F2A950", "#BF3E21", "#F2F2F2"],
  },
  {
    name: "Hiroshige",
    colors: ["#1B618C", "#55CCD9", "#F2BC57", "#F2DAAC", "#F24949"],
  },
  {
    name: "Hokusai",
    colors: ["#074A59", "#F2C166", "#F28241", "#F26B5E", "#F2F2F2"],
  },
  {
    name: "Hokusai Blue",
    colors: ["#023059", "#459DBF", "#87BF60", "#D9D16A", "#F2F2F2"],
  },
  {
    name: "Java",
    colors: ["#632973", "#02734A", "#F25C05", "#F29188", "#F2E0DF"],
  },
  {
    name: "Kandinsky",
    colors: ["#8D95A6", "#0A7360", "#F28705", "#D98825", "#F2F2F2"],
  },
  {
    name: "Monet",
    colors: ["#4146A6", "#063573", "#5EC8F2", "#8C4E03", "#D98A29"],
  },
  {
    name: "Nizami",
    colors: ["#034AA6", "#72B6F2", "#73BFB1", "#F2A30F", "#F26F63"],
  },
  {
    name: "Renoir",
    colors: ["#303E8C", "#F2AE2E", "#F28705", "#D91414", "#F2F2F2"],
  },
  {
    name: "VanGogh",
    colors: ["#424D8C", "#84A9BF", "#C1D9CE", "#F2B705", "#F25C05"],
  },
  {
    name: "Mono",
    colors: ["#D9D7D8", "#3B5159", "#5D848C", "#7CA2A6", "#262321"],
  },
  {
    name: "RiverSide",
    colors: ["#906FA6", "#025951", "#252625", "#D99191", "#F2F2F2"],
  },
];
