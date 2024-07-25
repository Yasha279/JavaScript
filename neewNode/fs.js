const fs=require('fs');
fs.exists('C:\Java Script\node\path.js',(exists)=>{
    console.log(exists ? 'found' : 'not found');
});

fs.stat('printHello.js',(err,data)=>{
    console.log(data);
})

fs.readFile('printHello.js',(err,data)=>{
    console.log(data.toString());
})

const data=fs.readFileSync('printHello.js');
console.log(data.toString());

fs.writeFile('demo.txt','data',(err,data)=>{
    console.log(data);
})

fs.appendFile('demo.txt',' che',(err,data)=>{
         console.log(data);
})

fs.unlink('demo.txt',(err)=>{
    if(err){throw err}
    console.log("txt file deleted");
})