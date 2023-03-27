const db = require("../db.js")
let dayjs = require("dayjs")
//分页获取文章列表(有分类id显示分类否则显示全部)
let getBlogByPage = async (lang, page, classId) => {
	let start = (page ? page : 1) * 10 - 10
	let sql = "",
		sql2 = ""
	if (classId) {
		sql = `SELECT * FROM blog b
		LEFT JOIN classify cla
		on cla.class_id=b.class
		WHERE b.class=${classId}
		AND lang='${lang}'
		ORDER BY b.createdate DESC
		LIMIT ${start},10;`
		sql2 = `select COUNT(*) as total from blog where class=${classId}`
	} else {
		sql = `select * from blog where status=1 AND lang='${lang}' limit ${start},10 `
		sql2 = `select COUNT(*) as total from blog`
	}
	let content = await db.Query(sql)
	let total = await db.Query(sql2)
	content.forEach((item, index, arr) => {
		arr[index].date = dayjs(arr[index].date).format("YYYY-MM-DD")
		arr[index].createdate = dayjs(arr[index].createdate).format("YYYY-MM-DD")
	})
	// console.log({ total: total[0].total, content })
	return { total: total[0].total, content }
}

//通过id获取文章详情
let getArticle = async (id) => {
	let sql = `select b.id,b.title,b.content,b.date,b.createdate,b.status,b.class,c.cnname 
	from blog as b 
	LEFT JOIN classify as c 
	on b.class = c.class_id 
	where id=${id}`
	return (await db.Query(sql))[0]
}
module.exports = {
	getArticle,
	getBlogByPage,
}
