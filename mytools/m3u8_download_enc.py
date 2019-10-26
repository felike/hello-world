import os
import time
import m3u8
import requests
from glob import iglob
from natsort import natsorted
from urllib.parse import urljoin
from dataclasses import dataclass
from concurrent.futures import ThreadPoolExecutor
from Crypto.Cipher import AES

 
@dataclass
class DownLoad_M3U8(object):
    m3u8_url  : str
    file_name : str
    refer : str
 
    def __post_init__(self):
        self.headers   = {'Upgrade-Insecure-Requests': '1','User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36',
		'Connection': 'keep-alive', 'Origin': 'http://pc-shop.xiaoe-tech.com', 
		'Referer': 'http://pc-shop.xiaoe-tech.com/appiXguJDJJ6027/video_details?id=v_5ce3b6af61b3e_NjXDErJQ',}
        self.key_headers   = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36',
		'Origin': 'http://pc-shop.xiaoe-tech.com', 
		'Referer': 'http://pc-shop.xiaoe-tech.com/appiXguJDJJ6027/video_details?id=v_5ce3b6af61b3e_NjXDErJQ',}
		
        self.threadpool = ThreadPoolExecutor(max_workers=10)
        if not self.file_name:
            self.file_name = 'new.mp4'
            
        if self.refer:
            self.key_headers['Referer'] = self.refer
            self.headers['Referer'] = self.refer

 
    def get_ts_url(self):
        m3u8_obj = m3u8.load(self.m3u8_url, headers= self.headers)
        base_uri = m3u8_obj.base_uri

        if len(m3u8_obj.keys) > 0:
            key_uri = m3u8_obj.keys[-1].uri
            key = requests.get(key_uri,headers = self.key_headers).content
            self.key = key
        
        for seg in m3u8_obj.segments:
            yield urljoin(base_uri,seg.uri)
            
    def download_single_ts(self,urlinfo):
        url,ts_name = urlinfo
        res = requests.get(url,headers = self.headers)
        with open(ts_name,'wb') as fp:
            fp.write(res.content)
    
 
    def download_all_ts(self):
        ts_urls = self.get_ts_url()
        
        for index,ts_url in enumerate(ts_urls):
            print (ts_url)
            self.threadpool.submit(self.download_single_ts,[ts_url,f'{index}.ts'])
            
        self.threadpool.shutdown()
 
    def run(self):
        self.download_all_ts()
        if self.key:
            cryptor = AES.new(self.key, AES.MODE_CBC)

        ts_path = '*.ts'
        with open(self.file_name,'wb') as fn:
            for ts in natsorted(iglob(ts_path)):
                with open(ts,'rb') as ft:
                    scline = ft.read()
                    if self.key:
                        scline = cryptor.decrypt(scline)
                    fn.write(scline)
        for ts in iglob(ts_path):
            os.remove(ts)
 
if __name__ == '__main__':
    
    m3u8_url  = 'http://vod2.xiaoe-tech.com/9764a7a5vodtransgzp1252524126/464811c05285890789353268784/drm/v.f230.m3u8?t=5db41716&us=918192&sign=515e331a6616a4ea8cebd3e5c79a4276'
    refer = 'http://pc-shop.xiaoe-tech.com/appiXguJDJJ6027/video_details?id=v_5ce3a3d3dbd03_i56SJw5y'
    file_name = '18.mp4'
 
    start = time.time()
 
    M3U8 = DownLoad_M3U8(m3u8_url,file_name,refer)
    M3U8.run()
 
    end = time.time()
    print ('耗时:',end - start)
