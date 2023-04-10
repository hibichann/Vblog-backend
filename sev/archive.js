const db = require("../db.js")
// 使用 Array.reduce() 函数对博客文章进行分组
let getArchive = async (lang) => {
	let sql = `SELECT * FROM blog where blog.lang='${lang}' ORDER BY createdate ASC;`
	const blogList = (await db.Query(sql)).reverse()
	// 使用 Array.reduce() 函数对博客文章进行分组
	const blogGroups = blogList.reduce((groups, blog) => {
		// 获取创建日期的年份和月份
		const yearMonth = blog.createdate.toISOString().slice(0, 7)
		// 如果该月份的分组不存在，则创建一个新的分组
		if (!groups[yearMonth]) {
			groups[yearMonth] = []
		}
		// 将文章添加到对应的分组中
		groups[yearMonth].push(blog)
		return groups
	}, {})
	// 对每个分组进行排序
	Object.values(blogGroups).forEach((group) => {
		group.sort((a, b) => {
			return new Date(b.createdate) - new Date(a.createdate)
		})
	})
	return {
		blogGroups,
		total: (
			await db.Query(`SELECT COUNT(*) AS total FROM blog WHERE lang='${lang}'`)
		)[0].total,
	}
}
module.exports = {
	getArchive,
}
