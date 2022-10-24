import re
import sys
from genericpath import exists

project_name = 'Open Discogs'
database_type = 'PostgreSQL'

if len(sys.argv) < 2:
    print('missing path argument')
    exit(1)

if len(sys.argv) == 3:
    project_name = sys.argv[2]

if len(sys.argv) == 4:
    database_type = sys.argv[3]

def get_prepend(name, db_type, readme):
    return '''Project {} {{
    database_type: \'{}\'
    note: \'\'\'
{}
\'\'\'
}}
'''.format(name.strip(), db_type.strip(), readme.strip())

def get_indent(depth):
    return '    '*depth

def get_depth_mod(line):
    d = 0
    for c in line:
        d += 1 if c == '{' else 0
        d -= 1 if c == '}' else 0
    return d

def read(path):
    try:
        with open(path, 'r') as f: return f.read() 
    except BaseException as err:
        print(err.args[1] +": " + path)
        exit(1)

project_regex = re.compile(r"^.*([p|P][r|R][o|O][j|J][e|E][c|C][t|T][ a-zA-Z0-9.,_-]+[{]).*$")
prepend = get_prepend(project_name, database_type, read('README.md'))
lines = read(sys.argv[1]).splitlines()
length = len(lines)
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
    
    data += next_line + '\n'
    if d_mod > 0:
        depth += d_mod
    idx += 1

p_name = project_name
if len(sys.argv) >= 3:
    p_name = sys.argv[2].replace(' ', '_') + '_prepended.dbml'
p_name = p_name.lower()
f_mod_opt = 'x'
if exists(p_name):
    f_mod_opt = 'w'

with open(p_name, f_mod_opt) as dest: dest.write(prepend + data)