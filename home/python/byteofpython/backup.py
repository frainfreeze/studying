import os, sys, time
__version__ = 0.1

def backup(source_dir, comment, target_dir = r'backup'):
    """ backup(source_dir, comment, target_dir = r'backup')"""

    source_dir = [r'test']

    today = target_dir + os.sep + time.strftime('%Y%B%d')
    rn = time.strftime('%H%M%S')

    if len(comment)!=0:
        target = today + os.sep + rn + '_' \
        + comment.replace(' ','_') + '.zip'
    else:
        target = today + os.sep + rn + '.zip'

    if not os.path.exists(today):
        os.makedirs(today) # makedirs() for making nested dirs

    zip_cmd = 'zip -r {} {} '.format(target, ' '.join(source_dir))

    if os.system(zip_cmd) == 0:
        return "backup successful."
    else:
        return "backup failed."

if __name__ == '__main__':
    if len(sys.argv) == 0 or len(sys.argv) > 3:
        print('Usage: backup.py folder_to_zip "your comment"')
    else:
        backup(sys.argv[1],sys.argv[2])
