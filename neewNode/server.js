const http=require("http");

server=http.createServer((req,res)=>{
    res.statusCode=200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World from me');
});

server.listen(3000,()=>{
    console.log("server is running http://127.0.0.1:3000/");
})





