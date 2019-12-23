function [nocolors,g,graf2] = graphcolornaya(graf)

for ii=0:1000
    colors(ii+1,1) = ii;
end
counter = 0;
problem = 0;
yy = size(graf,1);
graf2 = zeros(size(graf,1),1);
graf2 = graf2 + ii + 1;

%{
graf = [0,1,1,1,0,0,0,0,0,0;
        1,0,1,0,0,0,0,0,0,0;
        1,1,0,1,1,0,0,0,0,0;
        1,0,1,0,0,1,0,0,0,0;
        0,0,1,0,0,1,1,0,1,0;
        0,0,0,1,1,0,0,0,1,1;
        0,0,0,0,1,0,0,1,0,0;
        0,0,0,0,0,0,1,0,1,0;
        0,0,0,0,1,0,0,1,0,1;
        0,0,0,0,0,1,0,0,1,0];




graf = rand(no_vertex);
graf = graf .* graf';
graf = uint8(graf);
%}

no_vertex = size(graf,1);
for ii = 1:no_vertex
    vertex_names(ii) = ii;
end
rate_list = zeros(size(graf,1),1);

field1 = 'vertex_id'; value1 = [];
field2 = 'vertex_rates'; value2 = zeros(10,1);
field3 = 'adj'; value3 = zeros(10,10);
field4 = 'colors'; value4 = zeros(10,1);
field5 = 'colored'; value5 = zeros(10,1);
g = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5);

for y = 1:yy
    g.colors(y) = 99;
    g.colored(y) = 0;
end

g.adj = graf;
% Colorit function
while(1)   
    counter = counter+1;
biggest = 1;
temp_rate = 0;
g.vertex_id = vertex_names;
if(counter == 1)
    for i = 1:yy
        for j = 1:yy
            if(g.adj(i,j)==1)
                rate_list(i) = rate_list(i) + 1;
            end
        end
    end
end

for w = 1:yy
    if(g.colored(w) == 0)
        g.vertex_rates(w) = rate_list(w);
        if(temp_rate < g.vertex_rates(w))
            temp_rate = g.vertex_rates(w);
            biggest = w;
        end
    end
end
    g.colors(biggest) = colors(counter);
    fprintf('%d :color %d\n',g.vertex_id(biggest),g.colors(biggest));
    graf2(g.vertex_id(biggest),1) = g.colors(biggest);
    for e=1:yy
        if(g.adj(biggest,e) == 0 && biggest ~= e && g.colored(e) == 0)
            for t=1:yy
                if(g.adj(e,t)==1 && g.colors(t) == g.colors(biggest))
                    problem = 1;
                end
                if(t==yy-1 && problem==0)
                    g.colors(e) = colors(counter);
                    fprintf('%d :color %d\n',g.vertex_id(e),g.colors(e));
                    graf2(g.vertex_id(e),1) = g.colors(e);
                    g.colored(e) = 1;
                    problem = 0;
                elseif(t==yy-1)
                    problem = 0;
                end
            end
        end
    end
g.colored(biggest) = 1;

if(g.colored == 1)
    nocolors = max(g.colors)+1;
    disp('Graph Full Colored');
    return
end
end

nocolors = max(g.colors)+1;

                
