function off=cross(parent,croprop)
[pops,numvar]=size(parent);

for i=1:2:pops
    if croprop > rand
        r = randi([1 numvar],1,1);              % ����������|�C���g��I��
        offs(i,1:r)         = parent(i,1:r);
        offs(i,r+1:numvar)  = parent(i+1,r+1:numvar);   % r+1�Ԗڈȍ~�`�F���W
        offs(i+1,1:r)       = parent(i+1,1:r);
        offs(i+1,r+1:numvar)= parent(i,r+1:numvar);
    else    % ������m�����Ⴉ�����炻�̂܂܁B
        offs(i,:)  = parent(i,:);
        offs(i+1,:)= parent(i,:);
    end
end
off=offs;