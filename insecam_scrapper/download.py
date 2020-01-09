
import cv2
import time
import argparse
import os
import sys
import datetime
import multiprocessing

from insecam_scrap import default_savedir

class StreamDownloader:
    def __init__(self, name, url, interval, limit, relative_time, start_hour, end_hour):
        self.name = name
        self.url = url
        self.interval = float(interval)
        self.limit = int(limit)
        self.save_path = os.path.join(default_savedir, name)
        self.relative_time = int(relative_time)
        self.start_hour = int(start_hour)
        self.end_hour = int(end_hour)
    
    def __str__(self):
        return "[StreamDownloader] name:{}, url:{}, interval:{}, limit:{}, relative:{}, start:{}, end:{}".format(
            self.name, self.url, self.interval, self.limit, self.relative_time, self.start_hour, self.end_hour
        )
    
    def download(self):
        # creating the save directory if not exist
        if not os.path.exists(self.save_path):
            os.makedirs(self.save_path)

        print(self)

        img_counter = 0
        while img_counter < self.limit:
            time.sleep(self.interval)
            current_hour = (datetime.datetime.now().hour + self.relative_time) % 24
            if current_hour < self.start_hour:
                continue
            if current_hour > self.end_hour:
                continue

            cap = cv2.VideoCapture(self.url)
            ret, frame = cap.read()

            img_path = os.path.join(self.save_path, "image_{}.png".format(img_counter))
            cv2.imwrite(img_path, frame)
            # print("saved image {} to {}".format(img_counter, img_path))
            img_counter += 1
        print("finished downloading: {}".format(self.name))


def worker(stream_downloader):
    stream_downloader.download()
    return

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Download screencaps from insecam')
    parser.add_argument("streams_file", type=str, help="name of file with streams")
    args = parser.parse_args()

    stream_downloaders = []
    f = open(args.streams_file, "r")
    for line in f:
        stream_downloaders.append(StreamDownloader(*line.strip().split(",")))
    f.close()

    jobs = []
    for sd in stream_downloaders:
        p = multiprocessing.Process(target=worker, args=(sd,))
        jobs.append(p)
        
    try:
        for j in jobs:
            j.start()
        
        for j in jobs:
            j.join()

    except KeyboardInterrupt:
        for j in jobs:
            j.terminate()