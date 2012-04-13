%dump points
function dump_points( data, LABEL_TEST)

col = cell(10,1);
col{1,:} = [1 0 0];
col{2,:} = [0.5 0 0];
col{3,:} = [0 0.5 0];
col{4,:} = [0 0 0.5];
col{5,:} = [0 0 1];
col{6,:} = [0.5 0.5 0];
col{7,:} = [0 0.5 0.5];
col{8,:} = [0.5 0 0.5];
col{9,:} = [0.5 0.25 0];
col{10,:} = [0.25 0.25 0.5];

for c = 1:9
   indx = find(LABEL_TEST == c);
   
   scatter(data(indx,1), data(indx,3),3, col{c})
   hold on
end