import subprocess

def fetch_site_info(url):
    try:
        # Run curl command to fetch site information
        result = subprocess.run(['curl', '-s', url], capture_output=True, text=True)
        
        # Check if the command was successful
        if result.returncode == 0:
            print("Site information fetched successfully:")
            print(result.stdout)
        else:
            print("Failed to fetch site information:")
            print(result.stderr)
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python script.py <url>")
        sys.exit(1)
    
    url = sys.argv[1]
    fetch_site_info(url)
