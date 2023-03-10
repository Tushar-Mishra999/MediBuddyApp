const express = require("express");
const bcryptjs = require("bcryptjs");

const Client = require("../models/client");
const Seller = require("../models/seller");

const authRouter = express.Router();

//SIGNUP - CLIENT
authRouter.post('/client/signup', async (req, res) => {
  const {name, email, password, city} = req.body;
  const existingClient = await Client.findOne({email});
  if (existingClient) {
    return res
      .status(400)
      .json({msg: "Client with same email already exists!"});
  }

  let client = new Client({
    name, email, password, city
  });
  client = await client.save();
  res.json(client);
});

//SIGNUP - SELLER
authRouter.post('/seller/signup', async(req, res) => {
  const {storeName, email, password, city, address, phoneNumber} = req.body;
  const existingSeller = await Seller.findOne({email});
  if (existingSeller) {
    return res
      .status(400)
      .json({msg: "Seller with same email already exists!"});
  }

  let seller = new Seller({
    storeName, email, password, city, address, phoneNumber
  });
  seller = await seller.save();
  res.json(seller);
});

// SIGN IN
authRouter.post("/signin", async (req, res) => {
    try {
      const { email, password } = req.body;
      const client = await Client.findOne({ email });
      const seller = await Seller.findOne({ email });
      const user=client;
      if (!client&&!seller) {
        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }
      else if(!client){
        user=seller;
      }
      else{
        user=client;
      }

      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
  
      //const token = jwt.sign({ id: user._id }, "passwordKey");
      res.json({ msg:"Login successful", ...user._doc });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

module.exports = authRouter;