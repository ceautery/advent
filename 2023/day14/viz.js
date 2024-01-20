canvas = document.getElementById('c')
ctx = canvas.getContext('2d')
scale = 1
board = [[]]

vals = { '.': 0, 'O': 1, '#': 2 }

function drawBox(x, y, color) {
  ctx.fillStyle = color
  ctx.fillRect(x * 10 + 1, y * 10 + 1, 8, 8)
}

function draw() {
  ctx.resetTransform()
  ctx.clearRect(0, 0, canvas.width, canvas.height)
  ctx.scale(scale, scale)

  board.forEach((row, y) => row.forEach((val, x) => {
    if (val == 1) drawBox(x, y, 'blue')
    else if (val == 2) drawBox(x, y, 'brown')
  }))
}

function resize() {
  canvas.width = innerWidth
  canvas.height = innerHeight
  scale = Math.min(innerWidth, innerHeight) / 1000
  ctx.resetTransform()
  ctx.scale(scale, scale)
  draw()
}

function valuesFromLine(line) {
  return line.split('').map(c => vals[c])
}

async function init() {
  const response = await fetch('input.txt')
  const text = await response.text()

  board = text.trim().split("\n").map(valuesFromLine)

  onresize = resize
  resize()
}

init()
