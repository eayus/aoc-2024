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

i = 0
j = len(disk) - 1

while i < j:
    if disk[j] == ".":
        j -= 1
        continue

    if disk[i] == ".":
        disk[i], disk[j] = disk[j], disk[i]
        j -= 1

    i += 1


result = sum(map(lambda x: 0 if x[1] == "." else int(x[0]) * int(x[1]), enumerate(disk)))
print(result)