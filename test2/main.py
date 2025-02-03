import requests
import os
import time
from datetime import datetime

API_ADDRESS = 'api_datascientest'
API_PORT = 8000
API_ENDPOINTS = ['/v1/sentiment','/v2/sentiment']
URL = f'http://{API_ADDRESS}:{API_PORT}'
CREDENTIALS = {
    'alice':'wonderland',
    'bob': 'builder'
}
LOG_FILE_PATH=os.path.join('/app/logs', 'api_test.log')

def waiting_api():
    for i in range(10):
        try:
            r = requests.get(URL, timeout=3)
            print('Container of API is reachable')
            return True
        except requests.exceptions.ConnectionError:
            print('Attempt {i}/10 : impossible to reach container...')
            time.sleep(10)
    print('Container is not reachable')
    return False

def request_api(username,password,endpoint):

    r = requests.get(
        url=f'{URL}{endpoint}',
        params= {
            'username': username,
            'password': password
        }
    )
    status_code = r.status_code

    test_status = 'SUCCESS' if status_code == 200 else 'FAILURE'

    output = f'''
============================
     Authorization test
============================

request done at "{endpoint}"
| username={username}
| password={password}

expected result = 200
actual result = {status_code}

==>  {test_status}
'''
    return output

if waiting_api():
    if os.getenv('LOG','0') == "1":
        with open (LOG_FILE_PATH, 'a') as file:
            log_time = datetime.now().strftime("[%Y-%m-%d %H:%M:%S]")
            print(log_time)
            for username,password in CREDENTIALS.items():
                for endpoint in API_ENDPOINTS:
                    output = request_api(username,password,endpoint)
                    file.write(output)