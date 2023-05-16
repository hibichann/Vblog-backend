const db = require("../db.js")
let dayjs = require("dayjs")
//新增tag
let addTag = async (tag) => {
	let sql = `INSERT INTO tag (tag_name) VALUES('${tag}')`
	return await db.Query(sql)
}
//获取所有tag
let getAllTags = async () => {
	let sql = `SELECT * FROM tag`
	return await db.Query(sql)
}
//通过tag获取文章
let getBlogbyTag = async (lang, page, id) => {
	let start = (page ? page : 1) * 10 - 10
	let sql = `
	SELECT * from tag_blog
	LEFT JOIN blog
	on blog.id=tag_blog.blogid
	WHERE tag_blog.tagid=${id}
	and blog.lang='${lang}'
	LIMIT ${start},10;`
	//bytag暂时不区分中英文
	// AND blog.lang='${lang}'
	let sql2 = `select COUNT(*) as total from tag_blog where tagid=${id}`
	let content = await db.Query(sql)
	let total = await db.Query(sql2)
	content.forEach((item, index, arr) => {
		arr[index].createdate = dayjs(arr[index].createdate).format("YYYY-MM-DD")
	})
	return { total: total[0].total, content }
}
module.exports = {
	getAllTags,
	getBlogbyTag,
	addTag,
}
