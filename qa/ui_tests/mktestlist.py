import os
from fnmatch import fnmatch
import sys
import requests
import json
import yaml

def set_url(url):
    return "%s/%s.json" % (base_url, url)

def chk_response(response):
    if response.status_code != 200:
        print("HTTP/1.1 %s\n%s" % (response.status_code, response.content))
        sys.exit()

if __name__ == "__main__":

    if len(sys.argv) < 2:
        print("Not enough arguments (LAB_IP)")
        sys.exit()

    lab_ip = sys.argv[1]
    cfg = yaml.load(open("cfg.yaml"))

    host = cfg[lab_ip]["host"]
    port = cfg[lab_ip]["port"]
    env = cfg[lab_ip]["environment"]
    username = cfg[lab_ip]["username"]
    password = cfg[lab_ip]["password"]

    params = {"environment": env, "username": username, "password": password}
    headers = {"Content-Type": "application/json"}

    base_url = "http://%s:%s" % (host, port)

    session = requests.Session()
    r = session.request("POST", set_url("auth/signIn"), data=json.dumps(params), headers=headers, timeout=120)
    chk_response(r)

    true = True
    false = False
    null = None

    r = session.request("GET", set_url("info/environment"), timeout=120)
    chk_response(r)
    dict = json.loads(r.content)
    flags = dict["datacenters"][0]["flags"]
    manu_users = True if not "many_users" in flags else False

    r = session.request("GET", set_url("openStackService/list"), timeout=120)
    chk_response(r)
    dict = json.loads(r.content)
    services = [x["name"] for x in dict["openStackServices"] if x["name"] != None]
    volume = True if 'nova_volume' in services else False
    quantum = True if 'quantum' in services else False

    test_list = []
    for file in os.listdir('.'):
        if fnmatch(file, 'test_*.py'):
            if not volume:
                if fnmatch(file, 'test_*volume*.py'):
                    continue
            if not quantum:
                if fnmatch(file, 'test_networking.py') or fnmatch(file, 'test_routers.py'):
                    continue
            if not manu_users:
                if fnmatch(file, 'test_*_mu.py'):
                    continue
            test_list.append(file)

    tests = " ".join(test_list)
    print(tests)
