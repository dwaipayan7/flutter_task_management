import express from 'express';

const app = express();

app.get('/', (req, res) =>{
    res.send('Dwaipayan Biswas');
});

app.listen(8000, ()=>{
    console.log("server started at port 8000");
})