
%Comparison of SARSA AND TD(0) on cliff walking task
%Code by Sridhar.T

num_iters=1e3; % numer of iterations
states=ones(4,12); 
alpha=0.1;  % step size parameter
epsilon=0.1; % exploration
termstatesindex=8:4:48;
qvalues=zeros(48,4); % 48 states,4 actions
[q_SARSA,sarsareward]= SARSA(num_iters,epsilon,alpha,states,qvalues);

[q_Qlearning,qlearningreward]= Qlearn(num_iters,epsilon,alpha,termstatesindex,qvalues);
fprintf('Qlearning has learned the shortest path\n');
fprintf('SARSA has learned the roudabout policy\n');
fprintf('Press a key for plots');

plot(1:num_iters,smooth(sarsareward,50),'r');
hold on;
ylim([-100 0])
plot(1:num_iters,smooth(qlearningreward,50),'k');
xlabel('Numer of iterations');
ylabel('Average reward (smoothed)');
title(' Online performance on cliff task');
legend('SARSA','Q-Learning');
hold off;


