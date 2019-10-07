import shutil
from insecam_scrap import default_savedir

if __name__ == "__main__":
    shutil.make_archive(default_savedir, "zip", default_savedir)