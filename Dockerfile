FROM nginx-1.20.1
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

