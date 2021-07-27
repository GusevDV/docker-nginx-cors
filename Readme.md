## Bypassing cors with Docker + Nginx

Docker and Nginx is an elegant way to bypass Same Origin Policy during development Single Page Application(SPA) or apps using API.  This repository contains a nginx.conf and Dockerfile. It allows you to create a simple local reverse proxy.

### How to use

1. Clone this repository `git clone https://github.com/GusevDV/docker-nginx-cors.git`
2. Go to the folder `cd docker-nginx-cors`
3. Edit default.conf according to your wants. You can add new location or edit existing. If you are beginner to Nginx - [Nginx beginner guide](https://nginx.org/en/docs/beginners_guide.html)  
   

   ./nginx/default.conf
```nginx 
    # [...]
    location / {
        proxy_pass http://host.docker.internal:3000; # Proxy to Host machine (http://localhost:3000). You can change port.
	    proxy_set_header Host $host;
	    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	    proxy_set_header X-Real-IP $remote_addr;
    }
    
    # Proxing all request started with /api
    location /api { 
	    proxy_pass http://your_api_url; # Your API server
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
   }
   # Also you can copy new location here 
   # [...]
```
4. Build docker image `docker build -t nginx_cors .`
5. Run container  
   For Mac  
   `docker run -d --name nginx_cors -v "/$(pwd)/nginx:/etc/nginx/conf.d/" -p 80:80 nginx_cors`  
   For Linux  
   `docker run -d --add-host host.docker.internal:host-gateway --name nginx_cors -v "/$(pwd)/nginx:/etc/nginx/conf.d/" -p 80:80 nginx_cors`  
   For Windows CMD 
   `docker run -d --name nginx_cors -v "%cd%/nginx:/etc/nginx/conf.d/" -p 80:80 nginx_cors`  
   For Windows PowerShell  
   `docker run -d --name nginx_cors -v "${PWD}/nginx:/etc/nginx/conf.d/" -p 80:80 nginx_cors`
   
6. Open your project in browser (http://localhost and http://localhost/api).

Don't forget restart container after changing config `docker container restart nginx_cors`
   
