Play ruled surface
----

Demo: https://r.tiye.me/Quatrefoil-GL/play-ruled-surface/

### 使用者影响

配对使用正式 Calcit CLI/procs 0.34.2、Quatrefoil 0.3.1、Quaternion 0.2.19、
Touch Control 0.0.36、Pointed Prompt 0.0.24 和 JS-FFI 0.2.9。
线段结果现在明确为两个端点的 Tuple：cycloid 的每个端点是 xyz Tuple3，fractal-tree
的每个端点仍是完整 Quaternion。直接读取端点时推荐 let[]，不要把 Tuple 的位置
误当成 Option 再解包；原 Calcit List 运行表示和所有坐标值保持。

除官方格式化外，26 个原定义仅四个有预期变化：gen-trail 的输出与局部提示、
build-fractal-tree 的输出、两个 expand-branch 的输出及真实双元素字面量标注，
并补充合同说明。未改算式、递归顺序、终止阈值、默认参数、采样密度、随机调用、
ChordPair、状态派发、HUD、相机或生产路径。原测试/FFI 元数据保持，不新增 unsafe、
门禁例外、永久检查脚本或测试框架。真实开放状态与外部 JS 随机输出仍保留原检查，
unresolved Dynamic=12 不变，不使用包含 Dynamic 的伪 union 宣称债务消失。

### 开发与验收

```sh
caps --strict --ci
yarn install --immutable
caps verify --toolchain
yarn compile
yarn build
yarn dev
```

本轮完整strict、236/236定义、26/26公开定义、严格Caps/工具链、immutable、原质量检查及构建通过。
deprecated/dynamic-method=0；纯数值原生探针验证600条线段、端点值及递归数量。
项目原本无附带测试，不把临时探针说成原测试套件通过。此前0.32.1实际IAB默认视角仍极小，使用原w键靠近后
看到默认三角形与选项，a键改变相机，刷新恢复默认。未宣称五场景、11条线、六种树、
参数拖动、VR/gamepad或跨GPU都已验收；旧临时近景副本证据不冒充本轮验收。
默认可见性问题继续跟进issue #14，未改生产相机，也未强制清缓存或注入生成JS。

临时 Vite 内存检查在同一正式0.3.1图下比较原、新源码的五类默认场景，实际Three
几何位置/颜色/变换摘要一致且位置有限；两组cycloid参数的端点值和顺序一致。测试过程只为
Node隔离设置固定随机源，生产随机代码完全未改；原:on处理函数仍派发50条fiber，
再由原组件构建51个几何。默认fractal-line的:zero回退日志在原、新均存在，未隐藏。
模块初始化使用div/键盘监听占位，WebSocket绑定限制保留；不证明DOM命中、WebGL、
视觉、VR或跨GPU。本轮不合并或部署应用，最终精确CI/COS待远端执行。

VITE_BASE_URL默认相对路径。原PR按编号/run/attempt隔离COS前缀，使用action内置
逐文件校验，无额外校验脚本。main才使用原rsync路径；本地构建不代替实际上传/生产验收。

### License

MIT
