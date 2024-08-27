import subprocess
import json
import os

def replace_instance_id_in_json(file_path):
    try:
        with open(file_path, 'r') as file:
            data = json.load(file)

        if 'instance_id' in data:
            print(f"'instance_id' found in {file_path}. Replacing with $INSTANCE_ID...")
            
            jq_command = f'jq \'.instance_id = "$INSTANCE_ID"\' {file_path}'
            result = subprocess.run(jq_command, shell=True, capture_output=True, text=True)

            if result.returncode != 0:
                print(f"Error using jq: {result.stderr}")
                return False

            with open(file_path, 'w') as file:
                file.write(result.stdout)

            print(f"'instance_id' replaced successfully in {file_path}.")

        else:
            print(f"'instance_id' not found in {file_path}. Skipping...")

    except Exception as e:
        print(f"Error processing file {file_path}: {str(e)}")
        return False

    return True

def process_files_in_directory(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".json"):
                file_path = os.path.join(root, file)
                replace_instance_id_in_json(file_path)

if __name__ == "__main__":
    directory = input("Enter the directory path containing JSON files: ")
    process_files_in_directory(directory)

