import os
import uuid
def confirm_continue():
    """询问用户是否继续，并根据用户输入返回布尔值"""
    user_input = input("是否继续进行临时重命名？(按Enter或输入'y'继续，输入'n'取消): ").strip().lower()
    return user_input in ['', 'y']


def add_uuid_temp_rename():
    # 使用UUID作为临时前缀重命名所有文件
    for filename in os.listdir('.'):
        if os.path.isfile(filename):
            ext = os.path.splitext(filename)[1]  # 获取文件扩展名
            new_name = f"tmp_{str(uuid.uuid4())}{ext}"
            os.rename(filename, new_name)
    print('临时重命名避免后续重名')
            # print(f"Temporarily renamed '{filename}' to '{new_name}'")

def final_rename(user_prefix, user_suffix):
    # 根据用户指定的前缀和后缀重命名文件
    tmp_files = [f for f in os.listdir('.') if os.path.isfile(f) and f.startswith('tmp_')]
    tmp_files.sort()  # 确保按照文件创建时间或原始名称的某种顺序排序

    for index, tmp_filename in enumerate(tmp_files, start=1):
        new_name = f"{user_prefix}{index}.{user_suffix}"
        os.rename(tmp_filename, new_name)
        print(f"Renamed '{tmp_filename}' to '{new_name}'")

if __name__ == "__main__":
    if confirm_continue():
        add_uuid_temp_rename()  # 添加UUID临时前缀并重命名文件
        user_prefix = input("请输入文件名前缀: ")
        user_suffix = input("请输入文件扩展名(例如：jpg): ")
        final_rename(user_prefix, user_suffix)  # 最终按照用户指定的前缀和后缀重命名