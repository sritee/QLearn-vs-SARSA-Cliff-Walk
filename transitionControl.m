function [next_state,reward,signal]=transitionControl(cur_state,curact)

reward=-1; % default reward unless we fall or unless goal state reached.
 signal=0;
 r=cur_state(1);
 c=cur_state(2);
 
 switch curact
     case 1,
         c=c+1;      % right
     case 2,
         c=c-1;      % left
     case 3,
         r=r-1;      %up
     case 4,
         r=r+1;      %down
 end
 %check ifthe episode has terminated 
         if ((c>1) && (c<12) && r==4) % Henry has fallen off the cliff :(
             reward=-100;
             next_state=[r,c];
             signal=1;
             disp('Henry has fallen off the cliff');
             return
         end
        
        if(c==12 && r==4); % agent has succeded.Gudjob!
            reward=-1;
            next_state=[r,c];
            signal=1;
            disp('Agent Henry has won');
            return
        end
     % now make sure nothing is out of bounds
       if c<1
      c=1;
      end
      if r<1
          r=1;
      end
      if c>12
          c=12;
      end
      if r>4
          r=4;
      end
    
      next_state=[r,c];
          
 end
