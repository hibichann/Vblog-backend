/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `createdate` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '第一次生成日期',
  `status` int UNSIGNED NULL DEFAULT 1 COMMENT '删除标识 1存在，0已删除',
  `class` int NULL DEFAULT NULL COMMENT '分类',
  `lang` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cn',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blog
-- ----------------------------
INSERT INTO `blog` VALUES (1, '在element plus中保持菜单展开', '有时我们需要始终保持菜单的展开状态（如单独的全展开的分类页），而在element plus中并未提供相应的属性，但是可以首先为`el-menu`设置`default-openeds` 属性，值为需要展开的菜单，直接在`el-menu`的属性中，为菜单创建`ref`实例，并绑定`close`方法，在`close`方法中调用菜单实例身上的`open`方法来再次展开这个菜单，\r\n\r\n需要保持菜单展开的情况许多时候还需要去除二级菜单后面的小箭头，可以通过为`.el-sub-menu__icon-arrow`设置 `display: none !important;` 来清除二级菜单后的按钮。\r\n\r\n模板：\r\n\r\n```html\r\n<el-menu\r\n          class=\"el-menu-demo\"\r\n          :ellipsis=\"false\"\r\n          :default-openeds=\"[\'2\', \'2-4\']\"\r\n          @close=\"keepopen\"\r\n          ref=\"menuRef\"\r\n        >\r\n          <el-menu-item index=\"0\">LOGO</el-menu-item>\r\n          <div class=\"flex-grow\" />\r\n          <el-menu-item index=\"1\">Processing Center</el-menu-item>\r\n          <el-sub-menu index=\"2\">\r\n            <template #title>Workspace</template>\r\n            <el-menu-item index=\"2-1\">item one</el-menu-item>\r\n            <el-menu-item index=\"2-2\">item two</el-menu-item>\r\n            <el-menu-item index=\"2-3\">item three</el-menu-item>\r\n            <el-sub-menu index=\"2-4\">\r\n              <template #title>item four</template>\r\n              <el-menu-item index=\"2-4-1\">item one</el-menu-item>\r\n              <el-menu-item index=\"2-4-2\">item two</el-menu-item>\r\n              <el-menu-item index=\"2-4-3\">item three</el-menu-item>\r\n            </el-sub-menu>\r\n          </el-sub-menu>\r\n        </el-menu>\r\n```\r\n\r\n方法：\r\n\r\n```javascript\r\nconst menuRef = ref<any>(\'\')\r\nconst keepopen = (s) => {\r\n  menuRef.value.open(s)\r\n}\r\n```\r\n\r\n![效果](https://cdn.jsdelivr.net/gh/hibichann/picgo@main/img1.png)', '2022-10-11 13:57:47', 1, 12, 'cn');
INSERT INTO `blog` VALUES (57, '初识vue3', '#### 首次学习vue3时的笔记\n\n\n\n要从单个绑定获取多个 ref，请将  `ref`  绑定到一个更灵活的函数上：\n\n```html\n<div v-for=\"item in list\" :ref=\"setItemRef\"></div>\n```\n\n`$attrs`  现在包含了所有传递给组件的 `attribute`，包括  `class`  和  `style`。\n\n`ref()`用于基本类型 `reactive()`用于对象或数组 实现深层的响应式数据\n\n具名插槽 `slot=“qwe” `>>>>` v-solt:qwe`\n\n自定义事件需要用`emits`接受\n\n`setup`会接受两个参数\n\n`props`接收后为 setup 第一个参数\n\n`context `\n\n`attrs`值为对象，包含了未被`props`接受的来自父组件中的属性，包括`class`和`style`\n\n`slots`收到的插槽内容\n\n`emit`分发自定义事件的函数，用于触发自定义事件\n\n`expose` 指定组件向父组件暴露出去的公共函数\n\n```javascript\nwatch(prop, callback(newValue,oldValue)=>{\n    ...\n}, {immediate：true,deep:true})\n```\n\n###### watch 监听对象\n\n1 监听`reactive`定义的对象时 `oldValue`无法正确获取，\n\n2 监听`reactive`定义的对象时 强制开启了`deep`深层监视，无法关闭\n\n3 监听`reactive`定义对象中的某个属性 ，`prop`不能直接写`ob1.prop`需要写成返回值的样式 `()=>ob1.prop`\n\n4 监听对象中的深层属性如`ob1.job`，需要开启`deep`\n\n`watchEffect`默认开启`immediate`，只监视回调函数中被使用的值\n\n###### 生命周期\n\n创建前后>>` setup()`\n\n挂载前后`onBeforeMount`/`onMounted`\n\n更新前后`onBeforeUpdated`/`onUpdated`\n\n卸载前后`onBeforeUnmount`/`onUnmounted`\n\n###### 自定义 hook\n\n`toRef `创建一个 ref 对象，其 value 值指向另一个对象的中的某个属性\n\n```javascript\nconst name = toRef(person, \"name\");\n```\n\n`toRefs`可以展开一个 reactive 生成的 proxy 对象，让它成为一个普通对象，但该对象中的所有属性都是一个 ref 对象\n\n###### 移除了.`native`\n\n想要为组件绑定如 click 这种原生事件时，只需注意不要在 emits 中接受即可，即可防止 click 被视为自定义事件，相同的，若要重载 click 事件，在 emits 中接收即可\n\n移除过滤器\n\n`fragment `组件模板中可以不写根元素，减少了性能开销\n\n`teleport`组件可以将某一部分元素输送到某个指定元素中，更方便定位。\n\n###### 异步组件\n\n使用`defineAsyncComponent`来引入一个异步组件，\n\n```javascript\nimport {defineAsyncComponent} from \'vue\'\nconst Child=defineAsyncComponent(()=>import(\'./Components/Child\')\n```\n\n```html\n<suspense>\n    <template #default>\n        <!--此处放置真正的组件-->\n        <todo-list />\n    </template>\n    <template #fallback>\n        <!--此处放置骨架屏/渲染期间的显示-->\n        <div>Loading...</div>\n    </template>\n</suspense>\n```\n\n`shallowReactive`只有第一层数据拥有响应式\n\n如同\n\n```javascript\nlet ob1=shallowReactive({\n    name:\"zhangsan\",\n    age:18,\n    job:{\n        j1:\"stuff\"\n        salary:20 // 深层次的数据将会是一个普通的对象\n\n    }\n})\n```\n\n这样的数据，采用 shallowReactive 无法令 j1 和 salary 拥有响应式\n\n`shallowRef`对于基本类型等同于 ref，对于对象类型，不会添加响应式\n\nreadonly 只读\n\n```javascript\nob1 = readonly(ob1);\n```\n\n**_采用 readonly 不会令数据丢失响应式，但是会令数据不可更改_**\n\n`shallowReadonly`浅只读\n\n仅令 ob1 中的 name 和 age 不可更改，job 内部的属性可以更改\n\n`toRaw`令一个 reactive 数据失去响应式\n\n`markRaw`令一个 reactive 数据永远不能转为响应式\n\n**_isRef:检查一个值是否为一个 ref 对象_**\n**_lsReactive:检查一个对象是否是由 reactive 创建的响应式代理_**\n**_isReadonly:检查—个对象是否是由 readonly 创建的只读代理\nisProxy:检查一个对象是否是由 reactive 或者 readonly 方法创建的代理_**\n\n`provide`/`inject`适用于祖孙通信\n\n祖先组件无需指名传值给哪个后代，后代也无需声明数据来源\n\n```javascript\nprovide(name, data);\n```\n\n```javascript\ninject(name);\n```\n\ncustomRef 自定义 ref\n\n---', '2023-05-12 10:49:26', 1, 12, 'cn');
INSERT INTO `blog` VALUES (61, 'vue-router中使用i18n来进行网页标题的国际化', '思路很简单，在完成`vue-i18n`的安装后，第一次访问页面时候缓存默认语言，更改语言时，把当前语言缓存起来。在i18n中定义好不同语言的标题，然后在路由中引用作为meta.title。在路由后置守卫中进行网页标题的修改。\n\n代码：\n\n首先完成vue-i18n配置：\n\n```javascript\nimport { createI18n } from \'vue-i18n\'\nimport zh from \'./zh\'\nimport en from \'./en\'\nconst i18n = createI18n({\n    legacy: false,\n    locale: \'zh\', // 语言标识（缓存里面没有就用中文）\n    messages: {\n        zh,\n        en\n    }\n})\nif (window.localStorage.getItem(\'lang\') !== \'zh\' && window.localStorage.getItem(\'lang\') !== \'en\') {\n    window.localStorage.setItem(\'lang\', \'zh\')\n}\ni18n.global.locale.value = window.localStorage.getItem(\'lang\')\nexport default i18n\n```\n\nen.js:\n\n```javascript\nexport default {\n    meg: {\n        language: \'中文\',\n        home: \'Home\',\n        category: \'Category\',\n        tags: \'Tags\',\n        test: \'Test\',\n        articles: \'Articles\',\n        album: \'Album\',\n        finNew: \'Latest Articles\'\n    }\n}\n```\n\nzh.js:\n\n```js\nexport default {\n    meg: {\n        language: \'English\',\n        home: \'主页\',\n        category: \'分类\',\n        tags: \'标签\',\n        test: \'测试\',\n        articles: \'文章\',\n        album: \'相册\',\n        finNew: \'最新文章\'\n    }\n}\n```\n\nrouter.js\n\n```js\n//路由中的定义方式\n  {\n    path: \'/\',\n    name: \'home\',\n    component: HomeView,\n    meta: {\n      title: i18n.global.t(\'meg.home\')\n    }\n  }\n//...\n//后置守卫\nrouter.afterEach((to, from) => {\n  document.title = (i18n.global.locale.value === \'zh\') ? \'Hibi 博客站\' : \'Hibi Blog\' + \'-\' + to.meta.title\n})\n```', '2023-05-12 11:12:56', 1, 12, 'cn');
INSERT INTO `blog` VALUES (66, 'nginx部署刷新404', '解决刷新404问题：\n\n1. 使用hash模式路由\n\n   ```javascript\n   //vue3\n   const router = createRouter({\n     linkActiveClass: \'active\',\n     history: createWebHistory(),\n     routes\n   })\n   ```\n\n   ```javascript\n   //vue2\n   const router = new Router({\n       mode: \'hash\',\n       routes\n   })\n   ```\n\n   \n\n2. 在nginx中配置\n\n   ```nginx\n   location / {\n       root   html/dist;\n       index  index.html index.htm;\n       try_files $uri $uri/ /index.html;\n   }\n   ```\n\n   \n\n', '2023-05-12 11:25:50', 1, 199, 'cn');
INSERT INTO `blog` VALUES (69, 'react中使用...批量传递props', '```jsx\nclass App extends React.Component {\n    render() {\n        const { name1, age } = this.props\n        return (\n            <span>\n                {name1},{age}\n            </span>\n        )\n    }\n}\nconst p = { name1: \"tom\", age: 1 }\nconsole.log({ ...p }) //输出对象p\nconsole.log(...p) //报错，没有迭代器iterator\nroot.render(\n    <h1>\n        <App {...p}></App>\n        {/* 这里的花括号是react表明内部是js语法，而非es6展开运算符 */}\n        {/* 此处传入的是name1=\"tom\",age=1,而非p对象{name1:\'tom\',age:1} */}\n        {/* react为批量传递props提供了...迭代器，但仅能用于传递props */}\n    </h1>\n)\n```\n\n', '2023-05-12 11:28:21', 1, 12, 'cn');
INSERT INTO `blog` VALUES (70, 'solidity函数', '    function <function name>(<parameter types>) {internal|external|public|private} [pure|view|payable] [returns (<return types>)]\n\n1. `function`：声明函数时的固定用法，想写函数，就要以function关键字开头。\n\n2. `<function name>`：函数名。\n\n3. `(<parameter types>)`：圆括号里写函数的参数，也就是要输入到函数的变量类型和名字。\n\n4. `{internal|external|public|private}`：函数可见性说明符，一共4种。没标明函数类型的，默认`public`。合约之外的函数，即\"自由函数\"，始终具有隐含`internal`可见性。\n\n   - `public`: 内部外部均可见。\n   - `private`: 只能从本合约内部访问，继承的合约也不能用。\n   - `external`: 只能从合约外部访问（但是可以用`this.f()`来调用，`f`是函数名）。\n   - `internal`: 只能从合约内部访问，继承的合约可以用。\n\n   **Note 1**: 没有标明可见性类型的函数，默认为`public`。\n\n   **Note 2**: `public|private|internal` 也可用于修饰状态变量。 `public`变量会自动生成同名的`getter`函数，用于查询数值。\n\n   **Note 3**: 没有标明可见性类型的状态变量，默认为`internal`。\n\n5. `[pure|view|payable]`：决定函数权限/功能的关键字。`payable`（可支付的）很好理解，带着它的函数，运行的时候可以给合约转入`ETH`。\n\n6. `[returns ()]`：函数返回的变量类型和名称。\n\n关于pure/view：\n\n被pure修饰的函数不可读取也不可修改链上数据，即纯粹的函数，函数内部无法直接读到合约内的变量，可以传入参数进行处理\n\n被view修饰的函数可以读取链上数据，但是不能修改\n\n默认为payable状态，可读可写\n\n> 注：实际上pure/view修饰的函数gas费会更高，猜测原因是由于默认支持链上数据读写，所以减少功能需要额外的标识，提升了gas费', '2023-05-12 11:39:06', 1, 199, 'cn');
INSERT INTO `blog` VALUES (71, '错误的v-deep弃用警告', '在sass/scss项目中\n\n注意到项目中经常会有关于`::v-deep`的弃用警告，但是项目里又搜不到`::v-deep`\n\n![警告](https://cdn.jsdelivr.net/gh/hibichann/picgo@main/%E8%AD%A6%E5%91%8A.jpg)\n\n![没有::v-deep](https://cdn.jsdelivr.net/gh/hibichann/picgo@main/%E6%B2%A1%E6%9C%89v-deep.jpg)\n\n然后也去查看了源码里关于这段报错的：\n\n![vdeep判断部分源码](https://cdn.jsdelivr.net/gh/hibichann/picgo@main/202305151015288.png)\n\n打印n.nodes：\n\n![n.nodes](https://cdn.jsdelivr.net/gh/hibichann/picgo@main/202305151017431.png)\n\n依旧无果，最终在vuejs的issue中找到:\n\n[Misleading deprecation warning about \"::v-deep\", when \":deep\" is used in a nested block with SASS](https://github.com/vuejs/core/issues/4745)\n\n实际上是:deep使用错误，应该是\n\n```scss\n:deep(.ClassName){}\n  // more rules\n}\n```\n\n而非\n\n```scss\n:deep .ClassName{}\n  // more rules\n}\n```\n\n虽然后者也能工作，但是会错误地触发::v-deep弃用警告', '2023-05-15 14:16:52', 1, 12, 'cn');

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify`  (
  `class_id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `class_parent` int NULL DEFAULT NULL,
  `cnname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '中文名',
  `enname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '英文名',
  `status` int UNSIGNED NOT NULL DEFAULT 1 COMMENT '删除表示0删除，1可用',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`class_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 304 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of classify
-- ----------------------------
INSERT INTO `classify` VALUES (10, 100, '原生', 'Native', 1, 0);
INSERT INTO `classify` VALUES (12, 100, '框架', 'Framework', 1, 0);
INSERT INTO `classify` VALUES (17, 200, '数据库', 'Database', 1, 0);
INSERT INTO `classify` VALUES (18, 300, '饮食', 'Cook', 1, 0);
INSERT INTO `classify` VALUES (19, 300, '生活', 'Life', 1, 0);
INSERT INTO `classify` VALUES (99, 100, '其他', 'Others', 1, 99);
INSERT INTO `classify` VALUES (100, 0, '前端', 'Frontend', 1, 0);
INSERT INTO `classify` VALUES (199, 200, '其他', 'Others', 1, 99);
INSERT INTO `classify` VALUES (200, 0, '后端', 'Backend', 1, 0);
INSERT INTO `classify` VALUES (299, 300, '其他/未分类', 'Unsort', 1, 99);
INSERT INTO `classify` VALUES (300, 0, '其他', 'Others', 1, 99);

-- ----------------------------
-- Table structure for link
-- ----------------------------
DROP TABLE IF EXISTS `link`;
CREATE TABLE `link`  (
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pfp` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`link`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of link
-- ----------------------------
INSERT INTO `link` VALUES ('https://fireplace-of-despair.org/', 'https://api.fireplace-of-despair.org/static/1656947872.435161.jpg', 'Fire Of Despair', 'Chief Blog');

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `tag_id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (1, 'VueJS');
INSERT INTO `tag` VALUES (2, 'JavaScript');
INSERT INTO `tag` VALUES (3, 'HTML');
INSERT INTO `tag` VALUES (4, 'NodeJs');
INSERT INTO `tag` VALUES (5, 'MySQL');

-- ----------------------------
-- Table structure for tag_blog
-- ----------------------------
DROP TABLE IF EXISTS `tag_blog`;
CREATE TABLE `tag_blog`  (
  `blogid` int NULL DEFAULT NULL,
  `tagid` int UNSIGNED NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag_blog
-- ----------------------------
INSERT INTO `tag_blog` VALUES (1, 1);
INSERT INTO `tag_blog` VALUES (1, 2);
INSERT INTO `tag_blog` VALUES (1, 7);
INSERT INTO `tag_blog` VALUES (57, 1);
INSERT INTO `tag_blog` VALUES (57, 2);
INSERT INTO `tag_blog` VALUES (57, 3);
INSERT INTO `tag_blog` VALUES (61, 1);
INSERT INTO `tag_blog` VALUES (61, 16);
INSERT INTO `tag_blog` VALUES (66, 17);
INSERT INTO `tag_blog` VALUES (66, 1);
INSERT INTO `tag_blog` VALUES (69, 2);
INSERT INTO `tag_blog` VALUES (69, 14);
INSERT INTO `tag_blog` VALUES (70, 10);
INSERT INTO `tag_blog` VALUES (70, 11);
INSERT INTO `tag_blog` VALUES (70, 12);
INSERT INTO `tag_blog` VALUES (71, 19);
INSERT INTO `tag_blog` VALUES (71, 1);

SET FOREIGN_KEY_CHECKS = 1;
