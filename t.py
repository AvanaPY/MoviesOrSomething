import sys
from threading import Thread
from queue import Queue
import requests
import time

concurrent = 100


def do_work(n):
    while True:
        i, url = q.get()
        time.sleep(0.5)
        status, url = get_status(url)
        do_sth_with_result(status, (n, i, url))
        q.task_done()


def get_status(o_url):
    try:
        res = requests.get(o_url)
        return res.status_code, o_url
    except:
        return "error", o_url


def do_sth_with_result(status, result):
    n, i, url = result
    print(f'{i:3d} | {n:2d} : {url} {status}')

if __name__ == '__main__':
    q = Queue(concurrent * 2)
    for i in range(concurrent):
        t = Thread(target=do_work, args=(i,))
        t.daemon = True
        t.start()

    try:
        for i in range(400):
            q.put((i, "http://localhost:4000/api"))
        q.join()
    except KeyboardInterrupt:
        sys.exit(1)