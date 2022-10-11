# BaseDropper
A shell script to turn files into base64 strings to drop onto Windows systems via PowerShell using a badusb script.

Depending on the size of your source file, this is highly impractical.  I created it just to see if I could.  The initial script generation is rather quick, however, badusb typing all the base64 into PowerShell to drop the file to disk will take an exceedingly long time for this to be a plausible attack if your source file is more than a few kb.

Regardless, if you want to use it, feel free.  Don't do anything stupid/illegal.  You know the drill.  Don't blame me if you do and get caught.

To run the script: ./basedropper.sh /path/to/source/file /path/to/created/file
Example: ./basedropper.sh ~/exes/putty.exe ~/scripts/putty.txt
