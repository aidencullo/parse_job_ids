if __name__ == "__main__":
    raw = 'jobs'
    ext = 'txt'
    raw_filename = raw + '.' + ext
    file_access = 'r'
    with open(raw_filename, file_access) as f:
        print(f.read())
