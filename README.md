# trimage

A simple octave/matlab tool for trimming a white backgrounded image. The white background pixels are converted to transparent. Transparency is added to pixels at the edge of the image and the image background linearly.

Usage: trimage(inputFileName, outputFileName)

Input file must have 3 color channels. The output file will be a .png image with an alpha channel.

# Example

Input image
[[https://github.com/stubendek/repository/trimage/blob/master/example.jpg|alt=InputImage]]

Output image:
[[https://github.com/stubendek/repository/trimage/blob/master/example-result.png|alt=OutputImage]]