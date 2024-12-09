import itertools as it

f = open("input.txt", "r")
line = f.readline()

# Calc disk layout

disk = []

fid = 0
is_file = True
for n in line:
    c = str(fid) if is_file else '.'

    disk += [c] * int(n)

    if is_file:
        fid += 1
    is_file = not is_file

# print(disk)

# Shuffle to the left

print("len:", len(disk))

j = len(disk) - 1

# print("".join(disk))
while j >= 0:
    if j % 1000 == 0:
        print(j)

    if disk[j] == ".":
        j -= 1
        continue

    el = disk[j]
    size = len(list(it.takewhile(lambda c: c == el, disk[j::-1])))

    # Now look for free space from the left:

    i = 0
    while i < j:
        if disk[i] != ".":
            i += 1
            continue

        free = len(list(it.takewhile(lambda c: c == ".", disk[i:])))

        if free < size:
            i += free
            continue

        disk[i : i + size] = [el] * size
        disk[j : j - size : -1] = ["."] * size
        # print("".join(disk))
        break

    j -= size



result = sum(map(lambda x: 0 if x[1] == "." else int(x[0]) * int(x[1]), enumerate(disk)))
print(result)