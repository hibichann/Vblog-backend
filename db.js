let mysql = require("mysql2")
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

module.exports = {
	Query,
}
