% SARSA on cliff walk task
% Code by Sridhar
function [qvalues,reward_on_ep]=SARSA(num_iters,epsilon,alpha,states,qvalues)
 
 reward_on_ep=zeros(num_iters,1);
 
 for i=1:num_iters
     reward_acum=0;
     curstate=[4,1]; % initialize current state to start state
     terminate=0;
     
    csi=sub2ind(size(states),curstate(1),curstate(2)); % start state index
    [~,curact]=max(qvalues(csi,:)); % the greedy action corresponding to start state
     
     if (rand(1)< epsilon)
        temp=randperm(4,4);
        curact=temp(1);   
     end
     
     % Now S and A Have been taken!
      
     while(~terminate)
      disp(curstate);
      csi=sub2ind(size(states),curstate(1),curstate(2));
      [next_state,reward,signal]=transitionControl(curstate,curact);% find the transition and the reward
      q_cur=qvalues(csi,curact);
      
      reward_acum=reward_acum +reward; % the accumlated reward for the task!
       nsi=sub2ind(size(states),next_state(1),next_state(2));    
        [q_next,nextact]= max(qvalues(nsi,:)); %Pick A' greedily
     
        if (rand(1)< epsilon) % pick  A' random action, epsilon = 0.1
        temp=randperm(4,4);
        nextact=temp(1);
        q_next=qvalues(nsi,nextact);
        end
     
      % SARSA UPDATE for S,A not resulting in terminal state
       q_cur=q_cur + alpha*( reward + q_next - q_cur);
       qvalues(csi,curact)=q_cur;
      
     
      curstate=next_state; % backup for S,S'
      curact=nextact;      % backup for A,A'
      terminate=signal;
      end
      reward_on_ep(i,1)=reward_acum;
      disp('episode has ended');
      
 end

end
 
 
 
      
      
     
     
     
    
    









    





