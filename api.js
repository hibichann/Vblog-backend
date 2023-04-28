const express = require("express")
const router = express.Router()

const bodyParser = require("body-parser")
const card = require("./sev/card")
const cate = require("./sev/cate")
const art = require("./sev/art")
const tag = require("./sev/tag")
const archive = require("./sev/archive")
const search = require("./sev/search")
const save = require("./sev/save")

// 注册 body-parser 中间件
router.use(bodyParser.urlencoded({ extended: false }))
router.use(bodyParser.json())
//文章tag
router.get("/getTag", async (req, res) => {
	res.send(await art.getTag(req.query.id))
})
//上传文章
router.post("/postArticle", async (req, res) => {
	res.send(await save.postArt(req.body))
})
//获取归档
router.get("/getArchive", async (req, res) => {
	res.send(await archive.getArchive(req.headers["lang"]))
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
	res.send(
		await tag.getBlogbyTag(req.headers["lang"], req.query.page, req.query.tagid)
	)
})
//获取分类数据并转为树状
router.get("/getCateTree", async (req, res) => {
	res.send(await cate.getCateTree(req.headers["lang"]))
})
//通过id获取文章详情
router.get("/getArticle", async (req, res) => {
	res.send(await art.getArticle(req.query.id))
})
//获取所有tag
router.get("/getAllTags", async (req, res) => {
	res.send(await tag.getAllTags())
})
//右侧卡片1 三类总数
router.get("/getCard1", async (req, res) => {
	res.send(await card.getCard1())
})
//右侧卡片4 最新五条
router.get("/getCard4", async (req, res) => {
	res.send(await card.getCard4(req.headers["lang"]))
})
//搜索
router.get("/search", async (req, res) => {
	res.send(await search.search(req.headers["lang"], req.query.str))
})
//友链
router.get("/getLink", async (req, res) => {
	res.send(await search.link())
})
module.exports = router
