import os
import platform
import logging

uselogsdir = True

if uselogsdir:
    if not os.path.exists(r'logs'):
        os.mkdir(r'logs')
    
    logging_file = os.path.join(r'logs','test.log')
else:
    if platform.platform().startswith('Windows'):
        logging_file = os.path.join(os.getenv('HOMEDRIVE'),
                                    os.getenv('HOMEPATH'),
                                    'test.log')
    else:
        logging_file = os.path.join(os.getenv('HOME'),'test.log')

print("Logging to", logging_file)

logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s : %(levelname)s : %(message)s',
    filename=logging_file,
    filemode='w',
)

logging.debug("Start of the program")
logging.info("Doing something")
logging.warning("Dying now")
