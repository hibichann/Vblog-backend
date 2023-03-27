const express = require("express")
const router = express.Router()

const card = require("./sev/card")
const cate = require("./sev/cate")
const art = require("./sev/art")
const tag = require("./sev/tag")
const archive = require("./sev/archive")

//获取归档
router.get("/getArchive", async (req, res) => {
	res.send(await archive.getArchive())
})
//分页获取文章列表(有分类id显示分类否则显示全部)
router.get("/getBlogByPage", async (req, res) => {
	res.send(
		await art.getBlogByPage(
			req.headers["lang"],
			req.query.page,
			req.query.classid
		)
	)
})
//分页获取文章列表通过tag(有分类id显示分类否则显示全部)
router.get("/getBlogbyTag", async (req, res) => {
	res.send(await tag.getBlogbyTag(req.query.page, req.query.tagid))
})
//获取分类数据并转为树状
router.get("/getCateTree", async (req, res) => {
	res.send(await cate.getCateTree())
})
//通过id获取文章详情
router.get("/getArticle", async (req, res) => {
	res.send(await art.getArticle(req.query.id))
})
//获取所有tag
router.get("/getAllTags", async (req, res) => {
	res.send(await tag.getAllTags())
})
//右侧卡片1
router.get("/getCard1", async (req, res) => {
	res.send(await card.getCard1())
})
//右侧卡片4
router.get("/getCard4", async (req, res) => {
	res.send(await card.getCard4())
})
module.exports = router