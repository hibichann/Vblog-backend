const db = require("../db.js")
let dayjs = require("dayjs")
//最新10篇
let getIndex = async (lang) => {
	return {
		content: await db.Query(`
    SELECT * FROM blog
    WHERE \`status\`=1
    and blog.lang='${lang}'
    ORDER BY createdate desc
    LIMIT 10`),
	}
}
//分页获取文章列表(有分类id显示分类否则显示全部)
let getBlogByPage = async (lang, page, classId) => {
	let start = (page ? page : 1) * 10 - 10
	let sql = "",
		sql2 = ""
	if (classId) {
		sql = `SELECT b.id, b.title, b.content, b.createdate, b.status, b.class, b.lang, cla.${lang}name as typename FROM blog b
		LEFT JOIN classify cla
		on cla.class_id=b.class
		WHERE b.class=${classId}
		AND b.status=1 
		AND b.lang='${lang}'
		ORDER BY b.createdate DESC
		LIMIT ${start},10;`
		sql2 = `select COUNT(*) as total from blog where class=${classId} and lang='${lang}'`
	} else {
		sql = `select b.id, b.title, b.content, b.createdate, b.status, b.class, b.lang, cla.${lang}name as typename from blog b
		LEFT JOIN classify cla
		on cla.class_id=b.class where b.status=1 AND b.lang='${lang}' limit ${start},10 `
		sql2 = `select COUNT(*) as total from blog where lang='${lang}'`
	}
	let content = await db.Query(sql)
	let total = await db.Query(sql2)
	content.forEach((item, index, arr) => {
		arr[index].createdate = dayjs(arr[index].createdate).format("YYYY-MM-DD")
	})
	// console.log({ total: total[0].total, content })
	return { total: total[0].total, content }
}

//通过id获取文章详情
let getArticle = async (id) => {
	let sql = `select b.id,b.title,b.content,b.createdate,b.status,b.class,c.cnname 
	from blog as b 
	LEFT JOIN classify as c 
	on b.class = c.class_id 
	where id=${id}`
	return (await db.Query(sql))[0]
}
//通过id获取标签
let getTag = async (id) => {
	let sql = `SELECT tag.tag_id, tag.tag_name
	FROM tag
	INNER JOIN tag_blog ON tag.tag_id = tag_blog.tagid
	WHERE tag_blog.blogid = ${id}
	GROUP BY tag.tag_id;`
	return await db.Query(sql)
}
module.exports = {
	getArticle,
	getBlogByPage,
	getTag,
	getIndex,
}
