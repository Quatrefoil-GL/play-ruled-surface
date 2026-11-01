Play ruled surface
----

Demo: https://r.tiye.me/Quatrefoil-GL/play-ruled-surface/

### 使用者影响

配对使用正式 Calcit CLI/procs 0.32.1，类型标注由官方 CLI 迁移。
Quatrefoil 0.2.0、Quaternion 0.2.19、Touch Control 0.0.35、Pointed Prompt 0.0.24、
JS-FFI 0.2.9 组成一致的正式依赖图。包龄明确为 60 分钟，无单版本豁免。
保留原类型/质量门禁和 hud! 页面提示，不新增验证脚本或测试框架，不提交生成目录。

本轮仅迁移官方类型标注格式和配对依赖。26个项目定义的完整code/schema/元数据/测试
与格式化后的原基线一致；Quaternion/V3/ChordPair合同、五场景、采样密度、状态分支、
相机和缩放不变。不宣称原开放UI/状态类型已全部闭合。

### 开发与验收

```sh
caps --strict --ci
yarn install --immutable
caps verify --toolchain
yarn compile
yarn build
yarn dev
```

完整strict、237/237定义、26/26公开定义、工具链配对、immutable安装及构建通过。
项目原本无附带测试，不新增验证框架。实际IAB默认视角仍极小，使用原w键靠近后
看到默认三角形与选项，a键改变相机，刷新恢复默认。未宣称五场景、11条线、六种树、
参数拖动、VR/gamepad或跨GPU都已验收；旧临时近景副本证据不冒充本轮验收。
默认可见性问题继续跟进issue #14，未改生产相机，也未强制清缓存或注入生成JS。

VITE_BASE_URL默认相对路径。原PR按编号/run/attempt隔离COS前缀，使用action内置
逐文件校验，无额外校验脚本。main才使用原rsync路径；本地构建不代替实际上传/生产验收。

### License

MIT
