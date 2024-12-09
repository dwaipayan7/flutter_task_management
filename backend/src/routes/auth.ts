import { Router, Request, Response } from "express";
import { db } from "../db";
import { users } from "../db/schema";
import { eq } from "drizzle-orm";

const authRouter = Router();

interface SignUpBody{
    name:string,
    email:string,
    password:string
}

authRouter.post('/signup', async(req: Request<{}, {}, SignUpBody>, res: Response) =>{

    try {

        const {name, email, password} = req.body;

       const existingUser = await db.select().from(users).where(eq(users.email, email));

       if (existingUser.length) {
         res.status(400).json({msg: "User with the same email already exist"})
         return;
       }

       

        
    } catch (e) {
        res.status(500).json({error: e});
    }

});

authRouter.get('/', (req, res) =>{

    res.send("Hey There Dwaipayan Here");

});

export default authRouter;