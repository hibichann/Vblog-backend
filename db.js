var mysql = require("mysql2")
var dayjs = require("dayjs")
let pool = mysql.createPool({
	host: "localhost",
	user: "root",
	password: "root",
	database: "blog",
	port: 3306,
	connectionLimit: 50, //允许连接数
	multipleStatements: true, //是否允许执行多条sql语句
	// timezone: "utc", //大坑，必须加这一句，否则时间不对
})
//封装数据库sql请求操作，返回的是一个包含对象的数组
let Query = (sql) => {
	return new Promise(function (resolve, reject) {
		//从连接池中拿一条链接
		pool.getConnection(function (err, connection) {
			if (err) return reject(err)
			connection.query(sql, function (error, res) {
				// console.log(res);
				connection.release()
				if (error) {
					return reject(error)
				}
				resolve(res)
			})
		})
	})
}
//分页获取文章列表(有分类id显示分类否则显示全部)
let getBlogByPage = async (page, classId) => {
	let start = (page ? page : 1) * 10 - 10
	if (classId) {
		var sql = `select * from blogcn where status=1 and class_id=${classId} limit ${start},10`
		var sql2 = `select COUNT(*) as total from blogcn where class_id=${classId}`
	} else {
		var sql = `select * from blogcn where status=1 limit ${start},10`
		var sql2 = `select COUNT(*) as total from blogcn`
	}
	let content = await Query(sql)
	let total = await Query(sql2)
	content.forEach((item, index, arr) => {
		arr[index].date = dayjs(arr[index].date).format("YYYY-MM-DD")
		arr[index].createdate = dayjs(arr[index].createdate).format("YYYY-MM-DD")
	})
	// console.log({ total: total[0].total, content })
	return { total: total[0].total, content }
}

//获取分类数据并转为树状
let getCateTree = async (name1) => {
	let sql = `select class_id as menuId,class_parent as menuParent,cnname as menuName from classify order by class_id`
	let sql1 = `select class_id as menuId,class_parent as menuParent,enname as menuName from classify order by class_id`
	let data1 = await Query(name1 ? sql : sql1)
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
//通过id获取文章详情
const fs = require("fs")
let getArticle = async (id) => {
	var sql = `select b.id,b.title,b.content,b.date,b.createdate,b.status,b.class,c.cnname from blogcn as b LEFT JOIN classify as c on b.class = c.class_id where id=${id}`
	let result = await Query(sql)
	// result[0].content = fs.readFileSync(result[0].content)
	return result[0]
}
module.exports = {
	Query,
	getBlogByPage,
	getCateTree,
	getArticle,
}
