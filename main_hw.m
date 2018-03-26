% genetic algorithm
% 81722092
% �n粊���

clear
close all

%% �O���[�o���ϐ��̒�`
global bound rng
global hid_num out_num in_num IH_num
global pops

%% NN �p�����[�^
% 
%  PREFORMATTED
%  TEXT
% 
in_num  = 2;                        % ���͑w�̃j���[������
hid_num = 5;                        % �B��w�̃j���[������
out_num = 1;                        % �o�͑w�̃j���[������
IH_num  = in_num  * hid_num;        % ���͑w����B��w�ւ̏d��
HO_num  = hid_num * out_num;        % �B��w����o�͑w�ւ̏d��
IHO_num = IH_num + HO_num;          % �S�d��

I_in  = zeros(in_num,1);            % ���͑w�ւ̓���
I_hid = zeros(hid_num,1);           % ���͑w����̏o�́A�B��w�ւ̓���
I_out = zeros(out_num,1);           % �B��w����̏o�́A�o�͑w�ւ̓���
%% �p�����[�^�̏�����
pops=30;                      % �̐�
maxgen=150;                    % ���㐔
crossp=0.8;                   % �����m��
mutatep=0.35;                 % �ˑR�ψيm��
bound=10*ones(IHO_num, 2); bound(:,1)=-10;
% bound = [-5 -4; -5 -4; 0 1; -1 0;
%          -4 -3; -1 0; 1 2; -1 0;
%          -6 -5; -7 -6; -1 0; 0 1;
%          -3 -2; -5 -4; 1 2; 0 1;
%          0 1; -7 -6; -2 -1; 0 1;
%          0 1; -1 1; 0 1; -1 0; 0 1];
numvar=size(bound,1);         % ���F�̂̒���
rng=(bound(:,2)-bound(:,1))'; % �ϐ��͈̔�

pop=zeros(pops,numvar);       % �̂̏�����
pop(:,1:numvar)=(ones(pops,1)*rng).*(rand(pops,numvar))+(ones(pops,1)*bound(:,1)'); % �̂̐���
   
%% ����̊J�n
for it=1:maxgen
    it
    fpop=sim_pendulum(pop);    % �K���x�̌v�Z
%     fpop=multipeak(pop);
    [cs,inds]=max(fpop);    % �G���[�g�@cs:�ő�l  inds:����
    bchrom=pop(inds,:);     % �G���[�g�̒l�̊i�[
    
    % �I��
    toursize=5;
    players=ceil(pops*rand(pops,toursize)); % �K���x�̑g�ݍ��킹
    scores=fpop(players);
    [a,m]=max(scores');
    pind=zeros(1,pops);
    for i=1:pops
        pind(i)=players(i,m(i));	
        parent(i,:)=pop(pind(i),:);	
    end
    
    % ����	
    child=cross(parent,crossp);
    
    % �ˑR�ψ�
    pop=mutate(child,mutatep);
     
%     mm=sim_pendlum(pop);	
%     maxf(it)=max(mm);	
%     meanf(it)=mean(mm);
%     
%     [bfit,bind]=max(mm);
%     bsol=pop(bind,:);
%     
    % �}�̍쐬
%     [x,y]=meshgrid([-1:0.05:1]);
%     r=sqrt(x.^2+y.^2);
%     s=sqrt((x-0.5).^2+y.^2);
%     ss=sqrt((x-0.8).^2+y.^2);
%     fff=exp(-2*r.^2)+2*exp(-1000*s.^2)+3*exp(-1000*ss.^2);
%     cla
%     mesh(x,y,fff),hold on

    % �e�̂̒l���v���b�g
%     plot3( pop(:,1),pop(:,2),mm,'r+');
    
%     % �K���x�̍����̂̒l���v���b�g
%     plot3( bsol(1),bsol(2),bfit,'md');
%     axis([-1.5 ,1.5,-1.5 ,1.5])
%     xlabel(bsol(1))
%     ylabel(bsol(2))
%     zlabel(bfit)
%     title(['Generation=',num2str(it)])
%     pause(0)

%     pop(inds,:)=bchrom;
    pop(1,:)=bchrom;
    save pop.mat pop
end
    
disp(['x=',num2str(bsol(1))])       %  NUM2STR   ���l�𕶎���ɕϊ�
disp(['y=',num2str(bsol(2))])
disp(['z=',num2str(bfit)])