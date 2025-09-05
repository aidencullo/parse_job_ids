from collections.abc import Iterable

def is_iterable(obj):
    return isinstance(obj, Iterable)

def is_int(obj):
    try:
        int(obj)
        return True
    except ValueError:
        return False

def is_job_id(element):
    return is_int(element) and len(element) > 2 and element[:2] == '18'

def contains_id(line):
    import re
    split_line = re.split(r"[ ()]", line)
    for item in split_line:
        if is_job_id(item):
            return True

def extract_id(line):
    import re
    split_line = re.split(r"[ ()]", line)
    for item in split_line:
        if is_job_id(item):
            return item

def main():
    
    raw = 'jobs'
    ext = 'txt'
    raw_filename = raw + '.' + ext
    file_access = 'r'
    ids = set()
    with open(raw_filename, file_access) as f:
        for l in f:
            if contains_id(l):
                id = extract_id(l)
                ids.add(id)
    return ids

def print_collection(collection):
    for el in collection:
        print(el)

if __name__ == "__main__":
    ids = main()
    print_collection(ids)
