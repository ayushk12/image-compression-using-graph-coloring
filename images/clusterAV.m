function [HC,LC] = clusterAV(LLBW,IHC,ILC)

sum = 0;
sum2 = 0;
countsum = 0;
ConLab = bwlabel(LLBW,8);
LC = ILC;
HC = IHC;
for kk = 1:max(ConLab)
    for ii = 1:size(ConLab,1)
        for jj = 1:size(ConLab,2)
            if ConLab(ii,jj) == kk
                sum = sum + IHC(ii,jj);
                sum2 = sum2 + ILC(ii,jj);
                countsum = countsum + 1;
            end
        end
    end
        for ii = 1:size(ConLab,1)
            for jj = 1:size(ConLab,2)
                if ConLab(ii,jj) == kk
                HC(ii,jj)= sum/countsum;
                LC(ii,jj)= sum2/countsum;
                countsum = countsum + 1;
                end
            end
        end
    sum = 0;
    sum2 = 0;
    countsum = 0;
end

