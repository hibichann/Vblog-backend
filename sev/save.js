const db = require("../db.js")
let postArt = async (req) => {
	const { title, content, cate, lang } = req
	const art = { title, content, class: cate, lang }
	await db.Query(
		"INSERT INTO blog SET ?",
		[art],
		function (error, results, fields) {
			console.log(error, results, fields)
		}
	)
	const result = await db.Query(
		"SELECT * FROM blog WHERE id = LAST_INSERT_ID()"
	)
	let values = req.tagarr
		.map((tagid) => {
			return `(${result[0].id}, ${tagid})`
		})
		.join(", ")
	let sql = `INSERT INTO tag_blog (blogid, tagid) VALUES ${values};`
	await db.Query(sql)
	return {}
}
module.exports = { postArt }
