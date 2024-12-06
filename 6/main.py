import numpy as np

f = open("input.txt", "r")
grid = np.array(list(map(lambda line: list(line.rstrip('\n')), f.readlines())))

height, width = grid.shape

def ascii_direction(c):
    match c:
        case "^":
            return np.array([-1, 0])
        case "v":
            return np.array([1, 0])
        case "<":
            return np.array([0, -1])
        case ">":
            return np.array([0, 1])
        case _:
            return None

def rotate_direction(d):
    return np.array([d[1], -d[0]])

def in_bounds(p):
    y = p[0]
    x = p[1]
    return y >= 0 and y < height and x >= 0 and x < width

def find_start():
    for y in range(height):
        for x in range(width):
            c = grid[y, x]
            d = ascii_direction(c)

            if not d is None:
                return np.array([y, x]), d

start_pos, start_direction = find_start()

def patrol():
    visited = set()

    pos = start_pos.copy()
    d = start_direction.copy()

    while True:
        current = (tuple(pos), tuple(d))

        if current in visited:
            return None

        visited.add(current)

        next_pos = pos + d

        if not in_bounds(next_pos):
            return visited

        next_c = grid[tuple(next_pos)]

        if next_c == '#':
            d = rotate_direction(d)
        else:
            pos = next_pos


# Part 1

visited = patrol()
part1 = len(set(map(lambda x: x[0], visited)))

print("Part 1:", part1)

# Part 2

part2 = 0

for y in range(height):
    for x in range(width):
        old = grid[y, x]

        if old == ".":
            grid[y, x] = "#"

            if patrol() is None:
                part2 += 1

            grid[y, x] = old

print("Part 2:", part2)
