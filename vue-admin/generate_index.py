import os
import sys
from pathlib import Path

# python generate_index.py

# 配置：要扫描的根目录（相对于当前脚本）
ROOT_DIR = "./src/api"  # 👈 修改为你自己的目录
OUTPUT_FILE = os.path.join(ROOT_DIR, "index.ts")

def get_all_ts_files(dir_path: str) -> list[Path]:
    """递归获取目录下所有 .ts 文件（排除 index.ts 和 .d.ts）"""
    ts_files = []
    root = Path(dir_path)
    if not root.exists():
        print(f"❌ 目录不存在: {root}")
        sys.exit(1)

    for file in root.rglob("*.ts"):
        if file.name == "index.ts" or file.name.endswith(".d.ts"):
            continue
        ts_files.append(file.resolve())
    return ts_files

def to_module_path(file_path: Path, root_dir: Path) -> str:
    """将绝对路径转为相对于 root_dir 的模块路径（用于 export）"""
    rel_path = file_path.relative_to(root_dir.parent if str(root_dir).endswith('/') else root_dir)
    # 去掉 .ts 后缀
    stem = str(rel_path)[:-3] if str(rel_path).endswith('.ts') else str(rel_path)
    # 统一使用正斜杠
    stem = stem.replace("\\", "/")
    # 确保以 ./ 开头
    if not stem.startswith("."):
        stem = f"./{stem}"
    return stem

def main():
    root = Path(ROOT_DIR).resolve()
    ts_files = get_all_ts_files(root)

    export_lines = []
    for file in ts_files:
        module_path = to_module_path(file, root)
        export_lines.append(f"export * from '{module_path}'")

    content = "\n".join(export_lines) + "\n"
    
    output_path = Path(OUTPUT_FILE)
    output_path.write_text(content, encoding="utf-8")

    print(f"✅ 已生成 {output_path}")
    print(f"📦 共导出 {len(export_lines)} 个模块")

if __name__ == "__main__":
    main()