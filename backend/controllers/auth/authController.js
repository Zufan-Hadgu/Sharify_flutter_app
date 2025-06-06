import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

import userModel from '../../models/userModel.js';  


export const register = async(req,res) =>{
     

    const{name,email,password} = req.body
    if (!name || !email || !password){
        return res.json({success:false,message:'MIssing detaile'})

    }
    try{
        const existingUser = await userModel.findOne({email})

        if (existingUser){
            return res.json({success: false,message:"user already exists"})

        }
        const hashedPassword = await bcrypt.hash(password,10);

        const user = new userModel({name,email,password: hashedPassword})

        await user.save();

        const token = jwt.sign({id:user._id,role: user.role},process.env.JWT_SECRET,{expiresIn:'7d'});

        res.cookie('token',token,{
            httpOnly: true,
            secure: process.env.Node_ENV == 'production',
            sameSite:process.env.NODE_ENV =='production'? 'none':'strict',
            maxAge: 7 * 24 * 60 * 60 * 1000


        });
        //sending welcome email
        const mailOptions = {
            from: process.env.SENDER_EMAIL,
            to: email,
            subject:"Welcome to Zufan",
            text: `welcome email_id: ${email}`
        }
        // Fix the typo when sending email
        
        return res.json({ success: true, message: 'User registered successfully' });


    }catch(error){
        res.json({success: false, message:error.message})
    }
}
export const login = async(req,res) =>{
    const {email,password} = req.body;
    if(!email || !password){
        res.json({success: false,message : 'email and password are requred'})

    }
    try{
        const user = await userModel.findOne({email});
        if(!user){
            return res.json({success:false,message:'Invalid email'})

        }
        const isMatch = await bcrypt.compare(password,user.password)
        if(!isMatch){
            return res.json({ success: false, message: 'Invalid password' });

        }

        const token = jwt.sign({id:user._id,role: user.role},process.env.JWT_SECRET,{expiresIn:'7d'});

        res.cookie('token',token,{
            httpOnly: true,
            secure: process.env.Node_ENV == 'production',
            sameSite:process.env.NODE_ENV =='production'? 'none':'strict',
            maxAge: 7 * 24 * 60 * 60 * 1000


        });
        return res.json({ success: true, message: 'User sign in successfully',role: user.role, token:user,token,id :user.id});


    }catch(error){
        return res.json({success:false,message: error.message})
    }

}

 


export const logout = async (req,res) =>{
    try{
        res.clearCookie('token',{
            httpOnly: true,
            secure: process.env.Node_ENV == 'production',
            sameSite:process.env.NODE_ENV =='production'? 'none':'strict',
            maxAge: 7 * 24 * 60 * 60 * 1000

        })

        return res.json({success:true,message:'Logged out'})
        
    }catch(error){
        return res.json({success:false,message: error.message})
    }

}


export const deleteAccount = async (req, res) => {
    try {
        const userId = req.user.id; // Get logged-in user ID

        const deletedUser = await userModel.findByIdAndDelete(userId);

        if (!deletedUser) {
            return res.status(404).json({ success: false, message: "User not found" });
        }

        res.status(200).json({ success: true, message: "Account deleted successfully" });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};
