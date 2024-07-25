const child_process=require('child_process');
child_process.exec('dir',(err,stdout,stdin)=>{
    console.log(stdout);
})

child_process.exec('dir',(err,stdout,stdin)=>{
    console.log(err);
})

child_process.exec('dir',(err,stdout,stdin)=>{
    console.log(stdin);
})

child_process.exec('fs.js',(err,stdout,stdin)=>{
    console.log(stdout);
})