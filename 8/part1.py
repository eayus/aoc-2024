import numpy as np

f = open("input.txt", "r")
grid = np.array(list(map(lambda line: list(line.rstrip('\n')), f.readlines())))
height, width = grid.shape

def in_bounds(p):
    y = p[0]
    x = p[1]
    return y >= 0 and y < height and x >= 0 and x < width

antennas = {}

for y in range(height):
    for x in range(width):
        c = grid[y, x]
        if c == '.':
            continue
        if c in antennas:
            antennas[c].add((y, x))
        else:
            antennas[c] = { (y, x) }

antinodes = set()

for _, nodes in antennas.items():
    nodes = list(nodes)
    pairs = [(n1, n2) for n1 in nodes for n2 in nodes if n1 != n2]

    for ((y1, x1), (y2, x2)) in pairs:
        dy, dx = (y2 - y1, x2 - x1)

        antinodes.add((y1 - dy, x1 - dx))
        antinodes.add((y2 + dy, x2 + dx))

antinodes = set(filter(in_bounds, antinodes))

print(len(antinodes))