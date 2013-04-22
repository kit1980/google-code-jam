import os
import sys

def main():
    results = {}
    success = True

    main_dir = os.getcwd()
    for root, dirs, files in os.walk('.'):
        if 'test' in dirs:
            os.chdir(root)
            if os.path.exists(os.path.join('test', 'tests.txt')):
                status = os.system('sbtl ' + os.path.join('test', 'tests.txt'))
                results[root] = (status == 0)
                if status != 0:
                    success = False
            os.chdir(main_dir)

    print 
    for p in sorted(results):
        print results[p], '\t', p
    if success:
        print "OK"
    else:
        print "FAIL"
        sys.exit(1)

if __name__ == "__main__":
    main()
