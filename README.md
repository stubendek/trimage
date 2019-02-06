# trimage

A simple octave/matlab tool for trimming a white backgrounded image. The white background pixels are converted to transparent. Transparency is added to pixels at the edge of the image and the image background linearly.

Usage: 
```
trimage(inputFileName, outputFileName)
```

Input file must have 3 color channels. The output file will be a .png image with an alpha channel.

# Example

Input image

![Input Image](https://github.com/stubendek/trimage/blob/master/example.jpg)

Output image:

![Output image](https://github.com/stubendek/trimage/blob/master/example-result.png)

(Click to see the difference)
