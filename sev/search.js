const db = require("../db.js")
//获取分类数据并转为树状
function searchBlog(str) {
	// 将输入字符串按照空格进行分割
	const keywords = str.split(" ")

	// 构造SQL查询语句
	let sql = "SELECT * FROM blog WHERE MATCH(title, content) AGAINST("

	// 将每个关键词添加到查询语句中
	for (let i = 0; i < keywords.length; i++) {
		sql += "'" + keywords[i] + "' "

		// 如果不是最后一个关键词，则添加逻辑运算符
		if (i < keywords.length - 1) {
			sql += "AND "
		}
	}

	// 完成SQL查询语句
	sql += ") ORDER BY "

	// 先按照title中匹配数量排序，再按照content中匹配数量排序
	for (let i = 0; i < keywords.length; i++) {
		sql += "(CASE WHEN title LIKE '%" + keywords[i] + "%' THEN 1 ELSE 0 END) + "
		sql +=
			"(CASE WHEN content LIKE '%" + keywords[i] + "%' THEN 1 ELSE 0 END) DESC"

		if (i < keywords.length - 1) {
			sql += ", "
		}
	}

	return sql
}
let search = async (lang, str) => {
	let sql = `	SELECT *,
	  CASE
	    WHEN title LIKE '%${str}%' THEN 1
	    WHEN content LIKE '%${str}%' THEN 2
	    ELSE 3
	  END AS priority
	FROM blog
	WHERE
	(blog.lang='${lang}' AND title LIKE '%${str}%') OR (blog.lang='${lang}' AND content LIKE '%${str}%')
	ORDER BY priority, id
	LIMIT 0, 10;`
	// let sql = searchBlog(lang, str)
	let data1 = await db.Query(sql)
	return data1
}
module.exports = {
	search,
}
