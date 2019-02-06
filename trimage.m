function trimage(filename, outputname)
% TRIMAGE Trim a white-backgrounded image. White pixels that are actually background pixels are converted to transparent.
% Usage: trimage(inputFileName, outputFileName)
% 

im = imread(filename);
[n, m, d] = size(im);

% add white frame to ensure that all pixels at the original frame will be reached.
im2 = [ones(1, m+2, 3)*255; ones(n, 1, 3)*255, im, ones(n, 1, 3)*255; ones(1, m+2, 3)*255];

% the alpha channel
alphaCH = zeros(n+2, m+2);

% pixels that were used during the process
deltwith = zeros(n+2, m+2);
edges =  zeros(n+2, m+2);

% start from the corner
stack = [1,1];
steps = 0;

% aW - if all color channel values are above aW, it is considered transparent,
aW = 230;
% the lowel level of gradual transparency
lW = 180;

while (size(stack, 1) > 0)
    steps++;
    oldSize = size(stack, 1);
    act = stack(oldSize, :);
    newSize = oldSize - 1;
    if (newSize > 0)
        stack = stack(1:end-1, :);
    else
        stack = [];
    end
    alphaCH(act(1,1), act(1,2)) = 1;
    % disp(['pixel: ' num2str(act(1,1)) ', ' num2str(act(1,2)) ', stack: ' num2str(size(stack, 1)) ' elements']);
    for i = -1:1
        for j = -1:1
            if (i == 0 && j == 0)
                continue;
            end
            nx = act(1,1) + i;
            my = act(1,2) + j;
            if (nx > n + 2 || nx < 1 || my > m + 2 || my < 1)
                continue;
            end
            if (deltwith(nx, my) == 1)
                continue;
            end
            % disp(['pixel: ' num2str(nx) ', ' num2str(my), ' val: [' num2str(im2(nx, my, 1)) ', ' num2str(im2(nx, my, 2)) ', ' num2str(im2(nx, my, 3)) ']']);
            % not transparent, but white: it should be transparent
            if (alphaCH(nx, my) == 0 && (im2(nx, my, 1) >= aW && im2(nx, my, 2) >= aW && im2(nx, my, 3) >= aW))
                % disp(['will insert ' num2str(nx) ', ' num2str(my)]);
                stack = [stack; nx, my];
                deltwith(nx, my) = 1;
            % edge, add transparency linear to the light value
            elseif (im2(nx, my, 1) + im2(nx, my, 2) + im2(nx, my, 3) > lW*3)
                val = (im2(nx, my, 1) + im2(nx, my, 2) + im2(nx, my, 3))/3;
                alphaCH(nx, my) = double(val-lW)/double(255-lW);
            end
        end
    end
end

% save the image
imwrite(im2(2:end-1, 2:end-1, :), outputname, 'png', 'Alpha', 255-255*alphaCH(2:end-1, 2:end-1));

end

