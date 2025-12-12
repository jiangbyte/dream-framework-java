import os
import argparse
from pathlib import Path

def merge_sql_files(input_dir: str, output_file: str = None, encoding='utf-8'):
    input_path = Path(input_dir).resolve()
    if not input_path.is_dir():
        raise ValueError(f"输入路径不是有效目录: {input_dir}")

    # 默认输出文件：输入目录下的 merged_output.sql
    if output_file is None:
        output_file = input_path / "merged_output.sql"
    else:
        output_file = Path(output_file).resolve()

    # 获取所有 .sql 文件，按文件名排序
    sql_files = sorted(input_path.glob("*.sql"))

    if not sql_files:
        print("⚠️ 警告：指定目录中没有找到 .sql 文件。")
        return

    # 确保输出目录存在（如果输出路径包含子目录）
    output_file.parent.mkdir(parents=True, exist_ok=True)

    with open(output_file, 'w', encoding=encoding) as outfile:
        for sql_file in sql_files:
            print(f"正在合并: {sql_file.name}")
            try:
                with open(sql_file, 'r', encoding=encoding) as infile:
                    content = infile.read()
                    outfile.write(f"\n-- ========== 来自文件: {sql_file.name} ==========\n")
                    outfile.write(content)
                    outfile.write("\n")
            except Exception as e:
                print(f"⚠️ 读取文件 {sql_file} 时出错，已跳过: {e}")

    print(f"✅ 合并完成！输出文件: {output_file}")

def main():
    parser = argparse.ArgumentParser(
        description="合并指定目录下的所有 .sql 文件为一个 SQL 脚本"
    )
    parser.add_argument("input_dir", help="包含 SQL 文件的输入目录")
    parser.add_argument(
        "output_file",
        nargs="?",  # 表示该参数可选
        default=None,
        help="输出的合并后 SQL 文件路径（可选，默认为 <input_dir>/merged_output.sql）"
    )
    parser.add_argument("--encoding", default="utf-8", help="文件编码，默认 utf-8")

    args = parser.parse_args()
    merge_sql_files(args.input_dir, args.output_file, args.encoding)

if __name__ == "__main__":
    main()

# python merge_sql_files.py ./gen/vue/sql/auths