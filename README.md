# DocDeck - 专业的 PDF 批处理工具 🧰

**DocDeck** 是一款功能丰富且操作直观的跨平台桌面应用，专为高效批量处理 PDF 文件而打造。它支持添加页眉页脚、合并文档、解除加密限制，并兼具命令行自动化能力。

<!-- TODO: 添加应用界面截图 -->

## ✨ 主要功能亮点

- **批量添加页眉/页脚**
  - 三种模式：文件名 / 自动编号 / 自定义文本
  - 支持字体、字号、颜色、位置 (X/Y 坐标) 全面自定义
  - 实时可视化预览页眉位置

- **智能字体推荐**
  - 自动扫描 PDF 内容，提取并推荐原始字体风格

- **PDF 合并**
  - 支持拖拽排序和合并预览
  - 可选添加页码，样式灵活自定义

- **PDF 解锁**
  - 支持移除打开密码与权限限制，兼容加密文档

- **跨平台支持**
  - 支持 **Windows、macOS、Linux**

- **命令行批处理**
  - 适用于自动化脚本及集成流程

## 🚀 安装与使用

稍后将提供 [Releases 页面](https://github.com/muxiaoxiii/DocDeck/releases) 下载链接（包含 Windows/macOS/Linux 打包版本）。

## 🛠️ 开发者指南

如需从源码运行或参与贡献，请按以下步骤操作：

```bash
# 克隆项目
git clone https://github.com/muxiaoxiii/DocDeck.git
cd DocDeck

# 创建虚拟环境（推荐）
python -m venv venv
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# 安装依赖
pip install -r requirements.txt

# 运行程序
python main.py
```

---

*Created with ❤️ by [muxiaoxi](https://github.com/muxiaoxiii/)*
