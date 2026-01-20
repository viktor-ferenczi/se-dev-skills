import sys

import requests
import os


def download_busybox():
    url = "https://frippery.org/files/busybox/busybox.exe"
    filename = "busybox.exe"

    # Get the current working directory path
    cwd = os.getcwd()
    file_path = os.path.join(cwd, filename)

    print(f"Downloading busybox from {url}")

    try:
        # stream=True allows us to download the file in chunks
        response = requests.get(url, stream=True)

        # This will raise an exception for 404 or 500 errors
        response.raise_for_status()

        with open(file_path, 'wb') as f:
            # Writing in 8KB chunks
            for chunk in response.iter_content(chunk_size=8192):
                if chunk:
                    f.write(chunk)

        print(f"Successfully downloaded: {file_path}")

    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")
        sys.exit(1)


if __name__ == "__main__":
    download_busybox()
