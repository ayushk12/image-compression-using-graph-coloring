clc
clear all
I = imread('ayush.jpg');
%imshow(I);
sX=size(i);
YCBCR = rgb2ycbcr(I);
%figure,imshow(YCBCR);
I5 = YCBCR(:,:,1);
I6 = YCBCR(:,:,2);
I7 = YCBCR(:,:,3);
fun1 = @(block_struct) ...
   std2(block_struct.data) * ones(size(block_struct.data));
I2 = blockproc(I5,[8 8],fun1);
%figure,imshow(I2);

fun2 = @(block_struct) ...
    std2(block_struct.data) * ones(size(block_struct.data));
I3 = blockproc(I2,[64 64],fun1);
%figure,imshow(I3);


z = 0;
count = 1;
for i = 1:64:size(I3,1)
    for j = 1:64:size(I3,2)
        z = z + I3(i,j);
        A(:,count) = I3(i,j);
        count = count + 1;
    end 
end
stda = z /(8*8);

sstd = std2(A);


[LL,LH,HL,HH] = dwt2(I5,'db3');
[LL2,LH2,HL2,HH2] = dwt2(I6,'db2');
[LL3,LH3,HL3,HH3] = dwt2(I7,'db2');
figure,imshow(LL);
figure,imshow(LH);
figure,imshow(HH);
figure,imshow(HL);

HH(1:94) = 0;
HH2(1:94) = 0;
HH3(1:94) = 0;

LLBWdistlum = pdist2(LL,LH);
LLBWdistchrB = pdist2(LL2,LH2);
LLBWdistchrR = pdist2(LL3,LH3);

LLBWLum = zeros(size(LLBWdistlum));
for ii = 1:size(LLBWdistlum,1)
    for jj = 1:size(LLBWdistlum,2)
        if LLBWdistlum(ii,jj) > 6000
            LLBWLum(ii,jj) = 1;
        end
    end
end

LLL = LLBWLum;

for ii=1:size(LLL,1)
    for jj = 1:size(LLL,2);
        if(LLL(ii,jj)==1)
            LLL(jj,ii)=1;
        end
    end
end

[nocolors,g,graf2] = graphcolornaya(LLL);
countll = 0;
ldist = zeros(size(graf2,1),3);
for kk = 1:size(graf2,1)
    for ll = 1:size(graf2,1)
        if(kk==ll)
            continue;
        end
        aaa = graf2(kk,1);
        bbb = graf2(ll,1);
        if(aaa == bbb)
            countll = countll + 1;
            ldist(kk,1) = ldist(kk,1) + abs(ll - kk);
            ldist(kk,2) = countll;
        end
    end
    if(countll==0)
        ldist(kk,1) = graf2(kk,1);
    end
    countll = 0;
end
ldist(:,3) = graf2(:);
%ldist
colorinfo = zeros(size(ldist,1),2);
for ii=1:size(ldist,1)
    if(ldist(ii,2)~=0)
     ldist(ii,1) = (ldist(ii,1) ./ ldist(ii,2))/2;   
     ldist(ii,2) = ldist(ii,2) ./ 2;
    end
end

ldist = flip(ldist);
for ii=1:size(ldist,1)
    for jj=ii+1:size(ldist,1)
        if((ldist(ii,3)==ldist(jj,3))&&ldist(jj,3)~=1500)
            ldist(jj,3) = 1500;
        end
    end
end

idx=any(ldist==1500,2);
out=ldist(idx,:);
ldist(idx,:)=[];
ldist = flip(ldist);
colorinfo = ldist;
colorinfo(any(isnan(colorinfo),2),:) = [];
codebook = colorinfo;

[~,idu] = unique(codebook(:,1));
codebook = codebook(idu,:);

probmax = sum(codebook(:,2));
codebook(:,2) = codebook(:,2) ./ probmax;

dict = huffmandict(codebook(:,1),codebook(:,2));
dict2 = huffmandict(codebook(:,3),codebook(:,2));

LLG = LL;
LHG = LH;
HLG = HL;
HHG = HH;

for ii=1:size(LL,1)
    for jj=1:size(LL,2)
        for countdict=1:size(codebook,1)
            if(dict2{countdict,1}==round(LL(ii,jj)))
                try
                    abc = dict2{countdict,2}(1,1:8);
                catch
                    try 
                       abc = dict2{countdict,2}(1,1:7);
                    catch
                        try
                            abc = dict2{countdict,2}(1,1:6);
                        catch
                            try
                                abc = dict2{countdict,2}(1,1:5);
                            catch
                                try
                                    abc = dict2{countdict,2}(1,1:4);
                                catch
                                    try
                                        abc = dict2{countdict,2}(1,1:3);
                                    catch
                                        try
                                            abc = dict2{countdict,2}(1,1:2);
                                        catch
                                            abc = dict2{countdict,2}(1,1);
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
               aab = dec2bin(abc);
               aab = aab.';
               aab = bin2dec(aab);
               LLG(ii,jj)=aab;
            end
        end
    end
end

abc = [];
aab = [];

for ii=1:size(LH,1)
    for jj=1:size(LH,2)
        for countdict=1:size(codebook,1)
            if(dict2{countdict,1}==round(LH(ii,jj)))
                try
                    abc = dict2{countdict,2}(1,1:8);
                catch
                    try 
                       abc = dict2{countdict,2}(1,1:7);
                    catch
                        try
                            abc = dict2{countdict,2}(1,1:6);
                        catch
                            try
                                abc = dict2{countdict,2}(1,1:5);
                            catch
                                try
                                    abc = dict2{countdict,2}(1,1:4);
                                catch
                                    try
                                        abc = dict2{countdict,2}(1,1:3);
                                    catch
                                        try
                                            abc = dict2{countdict,2}(1,1:2);
                                        catch
                                            abc = dict2{countdict,2}(1,1);
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
               aab = dec2bin(abc);
               aab = aab.';
               aaaaaa= aab;
               aab = bin2dec(aab);
               LHG(ii,jj)=aab;
            end
        end
    end
end

abc = [];
aab = [];

for ii=1:size(HL,1)
    for jj=1:size(HL,2)
        for countdict=1:size(codebook,1)
            if(dict2{countdict,1}==round(HL(ii,jj)))
                try
                    abc = dict2{countdict,2}(1,1:8);
                catch
                    try 
                       abc = dict2{countdict,2}(1,1:7);
                    catch
                        try
                            abc = dict2{countdict,2}(1,1:6);
                        catch
                            try
                                abc = dict2{countdict,2}(1,1:5);
                            catch
                                try
                                    abc = dict2{countdict,2}(1,1:4);
                                catch
                                    try
                                        abc = dict2{countdict,2}(1,1:3);
                                    catch
                                        try
                                            abc = dict2{countdict,2}(1,1:2);
                                        catch
                                            abc = dict2{countdict,2}(1,1);
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
               aab = dec2bin(abc);
               aab = aab.';
               aaaaaa= aab;
               aab = bin2dec(aab);
               HLG(ii,jj)=aab;
            end
        end
    end
end

abc = [];
aab = [];

for ii=1:size(HH,1)
    for jj=1:size(HH,2)
        for countdict=1:size(codebook,1)
            if(dict2{countdict,1}==round(HH(ii,jj)))
                try
                    abc = dict2{countdict,2}(1,1:8);
                catch
                    try 
                       abc = dict2{countdict,2}(1,1:7);
                    catch
                        try
                            abc = dict2{countdict,2}(1,1:6);
                        catch
                            try
                                abc = dict2{countdict,2}(1,1:5);
                            catch
                                try
                                    abc = dict2{countdict,2}(1,1:4);
                                catch
                                    try
                                        abc = dict2{countdict,2}(1,1:3);
                                    catch
                                        try
                                            abc = dict2{countdict,2}(1,1:2);
                                        catch
                                            abc = dict2{countdict,2}(1,1);
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
               aab = dec2bin(abc);
               aab = aab.';
               aab = bin2dec(aab);
              HHG(ii,jj)=aab;
            end
        end
    end
end

%{
[LHC,LLC,Conlab1] = clusterAV(LLBWLum,LH,LL);

LLBWchrB = zeros(size(LLBWdistchrB));
for ii = 1:size(LLBWdistchrB,1)
    for jj = 1:size(LLBWdistchrB,2)
        if LLBWdistchrB(ii,jj) > 3830.0
            LLBWchrB(ii,jj) = 1;
        end
    end
end
[LH2C,LL2C,Conlab2] = clusterAV(LLBWchrB,LH2,LL2);

LLBWchrR = zeros(size(LLBWdistchrR));
for ii = 1:size(LLBWdistchrR,1)
    for jj = 1:size(LLBWdistchrR,2)
        if LLBWdistchrR(ii,jj) > 4230.0
            LLBWchrR(ii,jj) = 1;
        end
    end
end

[LH3C,LL3C,Conlab] = clusterAV(LLBWchrR,LH3,LL3);


YI = idwt2(LLC,LHC,HL,HH,'db3');
YCBI = idwt2(LL2C,LH2C,HL2,HH2,'db2');
YCRI = idwt2(LL3C,LH3C,HL3,HH3,'db2');

%}

YI = idwt2(LLG,LHG,HLG,HHG,'db3');
YCBI = idwt2(LL2,LH2,HL2,HH2,'db2');
YCRI = idwt2(LL3,LH3,HL3,HH3,'db2');
YCBCR2(:,:,1) = YI;
YCBCR2(:,:,2) = YCBI;
YCBCR2(:,:,3) = YCRI;
Iout = uint8(YI);
imwrite(Iout,'ayushout.bmp');
imwrite(I5,'ayushBW.bmp');




%{
dict2 = huffmandict(codebook(:,3),codebook(:,2));
%[rowLL,colLL]=size(LL);
LHtemp=LH;
%dict2de=bi2de(dict2(:,2));
for itemp=1:size(LHtemp,1)
    for jtemp=1:size(LHtemp,2)
        for iitemp=1:size(dict2,1)
            if(round(LHtemp(itemp,jtemp))==dict2(iitemp,1))
                LHtemp(itemp,jtemp)=dict2(iitemp,2)
                
            end
        end
    end
end
imshow(LHtemp);
imshow(LH);
%}

