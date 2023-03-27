const express = require("express")
const cors = require("cors")
const apiRouter = require("./api")

const app = express()
app.use(cors())
app.use("/", apiRouter)

app.listen(3000, () => {
	console.log("http://localhost:3000")
})
