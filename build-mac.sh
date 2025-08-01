name: Build & Release DocDeck

on:
  push:
    tags:
      - 'v*'

jobs:
  build-macos:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install pyinstaller create-dmg

      - name: Run macOS build script
        run: ./build-mac.sh

      - name: Upload macOS Artifact
        uses: actions/upload-artifact@v4
        with:
          name: DocDeck-macOS-dmg
          path: dist/DocDeck-macOS.dmg

  build-windows:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install pyinstaller pillow

      - name: Convert PNG to ICO
        run: |
          python -c "from PIL import Image; Image.open('icon/docdeck.png').save('icon/docdeck.ico', format='ICO', sizes=[(256,256), (128,128), (64,64), (32,32), (16,16)])"

      - name: Clean dist folder
        run: Remove-Item -Recurse -Force dist\*

      - name: Build with PyInstaller
        run: pyinstaller --noconfirm --clean --windowed --name "DocDeck" --icon=icon/docdeck.ico main.py

      - name: Package as zip
        run: Compress-Archive -Path dist/DocDeck -DestinationPath "dist/DocDeck-Windows-${{ github.ref_name }}.zip"

      - name: Upload Windows Artifact
        uses: actions/upload-artifact@v4
        with:
          name: DocDeck-Windows-zip
          path: "dist/DocDeck-Windows-${{ github.ref_name }}.zip"

  build-linux:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install pyinstaller

      - name: Clean dist folder
        run: rm -rf dist/*

      - name: Build with PyInstaller
        run: pyinstaller --noconfirm --clean --windowed --name "DocDeck" --icon=icon/docdeck.png main.py

      - name: Package as zip
        run: |
          cd dist
          zip -r "../DocDeck-Linux-${{ github.ref_name }}.zip" "DocDeck"
          cd ..
          
      - name: Upload Linux Artifact
        uses: actions/upload-artifact@v4
        with:
          name: DocDeck-Linux-zip
          path: "DocDeck-Linux-${{ github.ref_name }}.zip"

  release:
    needs: [build-macos, build-windows, build-linux]
    runs-on: ubuntu-latest
    permissions:
      contents: write 
    steps:
      - name: Create GitHub Release
        uses: softprops/action-gh-release@v2
        with:
          files: |
            *.dmg
            *.zip