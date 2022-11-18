import re

project_pattern = "[p|P][r|R][o|O][j|J][e|E][c|C][t|T]"
name_str_pattern = "[ a-zA-Z0-9.,_-]"
project_regex = re.compile(
    r"^.*(" + project_pattern + name_str_pattern + "+[{]).*$", re.I)

dbml_path = 'database.dbml'
with open(dbml_path, 'r') as original:
    src = original.read()

lines = src.splitlines(True)
length = len(lines)

# Project Open Discogs {


def get_depth_mod(line):
    d = 0
    for i in range(len(line)):
        c = line[i]
        if c == '{':
            d += 1
            continue
        if c == '}':
            d -= 1
    return d


def get_indent(depth):
    return '   '*depth


depth = 0
data = ''
idx = 0

while idx < length:
    line = lines[idx]
    if project_regex.match(line) is not None:
        idx += 1
        c_depth = 1
        while c_depth > 0:
            c_depth += get_depth_mod(lines[idx])
            idx += 1
        line = lines[idx]
        while line == '\n' and idx < length:
            idx += 1
            line = lines[idx]
    d_mod = get_depth_mod(line)
    if d_mod < 0:
        depth += d_mod
    next_line = get_indent(depth) + line.lstrip()
    if not next_line.endswith('\n'):
        next_line += '\n'
    data += next_line
    if d_mod > 0:
        depth += d_mod
    idx += 1
