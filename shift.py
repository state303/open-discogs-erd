import os
import re
import sys
from copy import copy
from operator import contains

from genericpath import exists
from this import d


not_blank_regex = re.compile(r"^ ")
tbl_regex = re.compile(
    r"^(.*table)[ ]+[\'\"]?([a-zA-Z_-]+)[\'\"]?[ ]+(.*)$", re.I)
column_regex = re.compile(r"^[ ]*([a-z_-]+)(.*)$", re.I)
constraint_regex = re.compile(r"^[ ]*([a-z_-]+)([{])[ ]*$", re.I)
column_name_regex = re.compile(
    r"^[ ]*([\"]?[a-z_-]+[\"]?)[ ]+([a-z_-]+)[ ]*([\(][a-z0-9_-]+[\)])[ ]+(.*)$", re.I)
column_name_no_arg_regex = re.compile(
    r"^[ ]*([\"]?[a-z_-]+[\"]?)[ ]+([a-z_-]+)(.*)$", re.I)
column_extra_regex = re.compile(
    r"^[ ]*(\([a-z\"\_\-\,\.\ ]+\))[ ]*(\[[a-z\"\_\-\,\.\ ]+\])$", re.I)
ref_regex = re.compile(r"^[ ]*(ref)[ ]*(.*)$", re.I)


def open_file(path):
    f_flag = 'x'
    if exists(path):
        os.remove(path)
    return open(path, f_flag)


def is_blank(s):
    if s is None:
        return None
    return not_blank_regex.match(s) is not None


def strip_join(s):
    if s is None:
        return s
    r = ''
    for i in range(len(s)):
        str_part = s[i].strip()
        if len(str_part) == 0:
            continue
        r += s[i].strip()
        if i < len(s)-1:
           r += ' '
    return r


if len(sys.argv) < 3:
    print('requires 2 arguments: file_path and up or lo.')
    exit(1)

file_path = sys.argv[1]

if sys.argv[2].find('up') < 0 and sys.argv[2].find('lo') < 0:
    print("provide argument either up or lo")
    exit(1)

to_lower_case = sys.argv[2].count('lo') > 0

if not exists(file_path):
    print("file does not exists: " + file_path)
    exit(1)

f = open(file_path)

backup_file_path = file_path + ".backup"
f_backup = open_file(backup_file_path)

if to_lower_case:
    def mapper(s): return s.lower()
else:
    def mapper(s): return s.upper()

depth = 0

lines = []

src = f.readlines()
size = len(src)


class LineResolver:
    def __init__(self, pattern, group_size, indexes_for_mapping):
        self.pattern = pattern
        self.group_size = group_size
        self.indexes = indexes_for_mapping

    def resolve(self, input):
        m = self.pattern.match(input)
        if m is None:
            return None
        items = []
        for i in range(self.group_size):
            idx = i+1
            item = m.group(idx)
            if idx in self.indexes:
                item = mapper(item)
            items.append(item)
        return strip_join(items)


resolvers = [
    LineResolver(tbl_regex, 3, [2]),
    LineResolver(ref_regex, 2, [1, 2]),
    LineResolver(column_regex, 2, [1]),
    LineResolver(constraint_regex, 2, [1],),
    LineResolver(column_name_regex, 4, [1, 2]),
    LineResolver(column_extra_regex, 2, [1]),
    LineResolver(column_name_no_arg_regex, 3, [1])
]

idx = 0

while idx < size:

    line = src[idx]
    f_backup.write(line)

    l = line.strip()
    mod = line.count('}')

    if mod > 0:
        depth -= mod

    result = None
    for resolver in resolvers:
        result = resolver.resolve(l)
        if result is not None:
            break

    if result is None:
        result = l

    lines.append(' ' * (depth * 4) + result)
    mod = line.count('{')
    if mod > 0:
        depth += mod

f.close()
f_backup.close()

os.remove(file_path)
f = open_file(file_path)
size = len(lines)
for i in range(size):
    line = str(lines[i])
    f.write(line)
    if i < size - 1 and not line.endswith('\n'):
        f.write('\n')
f.close()
