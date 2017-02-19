%Q-learning on cliff task.
%Code by Sridhar

function [qvalues,reward_on_ep]=Qlearn(num_iters,epsilon,alpha,termstatesindex,qvalues)
 reward_on_ep=zeros(num_iters,1);
 
 
 
 for i=1:num_iters
     reward_acum=0;
     curstate=[4,1]; % initialize current state to start state
     states=ones(4,12);
     csi=sub2ind(size(states),curstate(1),curstate(2));
     
     while size(find(termstatesindex==csi),2)==0 % until State becomes terminal
      % Take A, in state S
      disp(curstate);
      csi=sub2ind(size(states),curstate(1),curstate(2));
      [q_cur,curact]=max(qvalues(csi,:)); % the greedy action corresponding to start
        
     if (rand(1)< epsilon)
        temp=randperm(4,4);
        curact=temp(1);
        q_cur=qvalues(csi,curact); % the exploratory action!
     end
     % A has been taken
      
      
      [next_state,reward,~]=transitionControl(curstate,curact);% find the transition and the reward
     
      reward_acum=reward_acum +reward; % the accumlated reward for the task!
     
       nsi=sub2ind(size(states),next_state(1),next_state(2)); % index of the next state
     
       q_max=max(qvalues(nsi,:)); % max q for next state for Q learning
       q_cur=q_cur + alpha*(reward + q_max - q_cur);% Q-update 
       qvalues(csi,curact)=q_cur; % update the table
       
      curstate=next_state; % backup for S,S'
      csi=sub2ind(size(states),curstate(1),curstate(2));
     end
     disp('episode has ended');
     reward_on_ep(i,1)=reward_acum;
 end
end
      
 