const express = require("express")
const db = require("./db")
const cors = require("cors")

const app = express()
let name1 = true
function validateLang(req, res, next) {
	const lang = req.headers["lang"]
	if (lang === "en") name1 = false
	else name1 = true
	next()
}
app.use(validateLang)
app.use(cors())
app.get("/getBlogByPage", async (req, res) => {
	res.send(
		await db.getBlogByPage(
			req.query.page,
			req.query.pageSize,
			req.query.classId
		)
	)
})

app.get("/getCateTree", async (req, res) => {
	res.send(await db.getCateTree(name1))
})
app.get("/getArticle", async (req, res) => {
	res.send(await db.getArticle(req.query.id))
})
app.listen(3000, () => {
	console.log("http://localhost:3000")
})
