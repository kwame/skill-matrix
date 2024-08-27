import os
import sys

def list_files_in_directory(directory):
    try:
        if not os.path.isdir(directory):
            print(f"Error: {directory} is not a valid directory.")
            return

        files = os.listdir(directory)
        
        file_list = [f for f in files if os.path.isfile(os.path.join(directory, f))]
        
        if file_list:
            print("Files in the directory:")
            for file_name in file_list:
                print(file_name)
        else:
            print(f"No files found in directory: {directory}")

    except Exception as e:
        print(f"An error occurred: {str(e)}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python list_files.py <directory_path>")
    else:
        directory = sys.argv[1]
        list_files_in_directory(directory)

