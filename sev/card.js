const db = require("../db.js")
//右侧卡片1
let getCard1 = async () => {
	let art = await db.Query(`SELECT 
    SUM(CASE WHEN lang='en' THEN 1 ELSE 0 END) AS enTotal, 
    SUM(CASE WHEN lang='cn' THEN 1 ELSE 0 END) AS cnTotal
  FROM 
    blog;`)
	let cate = await db.Query(`
    SELECT COUNT(*) as cateTotal FROM classify;`)
	let tag = await db.Query(`
    SELECT COUNT(*) as tagTotal FROM tag;`)
	return { art: art[0], cate: cate[0].cateTotal, tag: tag[0].tagTotal }
}
//右侧卡片4
let getCard4 = async () => {
	return await db.Query(`
    SELECT * FROM blog
    -- UNION ALL
    -- SELECT * FROM blogen e
    WHERE \`status\`=1
    ORDER BY createdate desc
    LIMIT 5`)
}
module.exports = {
	getCard1,
	getCard4,
}
