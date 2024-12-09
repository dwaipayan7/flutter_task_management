import express from 'express';
import authRouter from './routes/auth';

const app = express();

app.use(express.json());
app.use('/auth',authRouter);

app.get('/', (req, res) =>{
    res.send('Dwaipayan');
});

app.listen(8000, ()=>{
    console.log("server started at port 8000");
})