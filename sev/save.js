const db = require("../db.js")
let postArt = async (req) => {
	console.log(req)
	let sql = `INSERT INTO blog (title, content, class, lang) VALUES (:title,:content,:cate,:lang);`
	let res = await db.Query(sql, req)
	console.log(res)
	return {}
}
module.exports = { postArt }
