const db = require("../db.js")
const buildMultiKeywordQuery = (table, columns, lang, keywords) => {
	const keywordArray = keywords.split(" ")
	const query = `SELECT * FROM ${table} WHERE lang= '${lang}' AND`
	const subqueries = keywordArray.map((keyword) => {
		return `(${columns
			.map((column) => `${column} LIKE '%${keyword}%'`)
			.join(" OR ")})`
	})

	return query + subqueries.join(" AND ")
}

let search = async (lang, str) => {
	let sql = buildMultiKeywordQuery("blog", ["title", "content"], lang, str)
	let data1 = await db.Query(sql)
	return data1
}
let link = async () => {
	let sql = `select * from link`
	let data1 = await db.Query(sql)
	return data1
}
module.exports = {
	search,
	link,
}
