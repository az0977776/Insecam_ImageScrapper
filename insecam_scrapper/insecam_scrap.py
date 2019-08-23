import cv2
import time
import argparse
import os
import sys

default_savedir = "screencaps"

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Download screencaps from insecam')
    parser.add_argument("video_address", type=str, help="url of the livestream, ending in .mjpg")
    parser.add_argument("download_interval", type=int, help="how many seconds between each screencap")

    args = parser.parse_args()
    print("Downloading screencaps from livestream at {} at 1 frame every {} seconds".format(args.video_address, args.download_interval))

    # creating the save directory if not exist
    if not os.path.exists(default_savedir):
        os.makedirs(default_savedir)

    img_counter = 0
    while True:
        try:
            cap = cv2.VideoCapture(args.video_address)
            ret, frame = cap.read()
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

            img_path = os.path.join(default_savedir, "image_{}.png".format(img_counter))
            cv2.imwrite(img_path, frame)
            print("saved image {} to {}".format(img_counter, img_path))
            img_counter += 1
            time.sleep(args.download_interval)

        except KeyboardInterrupt:
            print("exiting download")
            break

        except:
            print(sys.exc_info()[0])
            continue