const db = require("../db.js")
//获取分类数据并转为树状
let getCateTree = async (lang) => {
	let sql = `select class_id as menuId,class_parent as menuParent,${lang}name as menuName from classify order by class_id`
	let data1 = await db.Query(sql)
	data1.forEach((item, index, arr) => {
		if (arr[index].menuId) {
			arr[index].menuId = arr[index].menuId.toString()
			arr[index].menuParent = arr[index].menuParent.toString()
		}
	})
	const listToTreeData = (data, rootValue) => {
		let arr = []
		data.forEach((item) => {
			if (item.menuParent == rootValue) {
				arr.push(item)
				let children = listToTreeData(data, item.menuId)
				children.length && (item.children = children)
			}
		})
		return arr
	}
	return listToTreeData(data1, 0)
}
//通过分类获取分类下文章总数
let getCateTotal = async (classid, lang) => {
	let sql = `SELECT 
	SUM(CASE WHEN lang='en' THEN 1 ELSE 0 END) AS enTotal, 
	SUM(CASE WHEN lang='cn' THEN 1 ELSE 0 END) AS cnTotal,
	classify.${lang}name AS class_name
  FROM 
	blog 
	INNER JOIN classify 
	  ON blog.class = classify.class_id
  WHERE 
	blog.class = ${classid};`
	return await db.Query(sql)
}
module.exports = {
	getCateTotal,
	getCateTree,
}
