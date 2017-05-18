
function [Best_flame_score,Best_flame_pos,Convergence_curve]=MFO(N,Max_iteration,lb,ub,dim,fobj,handles,value)
display('MFO is optimizing your problem');
Moth_pos=initialization(N,dim,ub,lb);
Convergence_curve=zeros(1,Max_iteration);
Iteration=1;
while Iteration<Max_iteration+1
    Flame_no=round(N-Iteration*((N-1)/Max_iteration));
    for i=1:size(Moth_pos,1)
        Flag4ub=Moth_pos(i,:)>ub;
        Flag4lb=Moth_pos(i,:)<lb;
        Moth_pos(i,:)=(Moth_pos(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;  
        Moth_fitness(1,i)=fobj(Moth_pos(i,:));
        All_fitness(1,i)=Moth_fitness(1,i);
     end
     if Iteration==1
        % Sort the first population of moths
        [fitness_sorted I]=sort(Moth_fitness);
        sorted_population=Moth_pos(I,:);
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
     else
        % Sort the moths
        double_population=[previous_population;best_flames];
        double_fitness=[previous_fitness best_flame_fitness];
        [double_fitness_sorted I]=sort(double_fitness);
        double_sorted_population=double_population(I,:);
        fitness_sorted=double_fitness_sorted(1:N);
        sorted_population=double_sorted_population(1:N,:);
        % Update the flames
        best_flames=sorted_population;
        best_flame_fitness=fitness_sorted;
    end
    
    Best_flame_score=fitness_sorted(1);
    Best_flame_pos=sorted_population(1,:);
      
    previous_population=Moth_pos;
    previous_fitness=Moth_fitness;
    
    a=-1+Iteration*((-1)/Max_iteration);
    
    for i=1:size(Moth_pos,1)
        
        for j=1:size(Moth_pos,2)
            if i<=Flame_no
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                Moth_pos(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(i,j);
            end
            
            if i>Flame_no
                distance_to_flame=abs(sorted_population(i,j)-Moth_pos(i,j));
                b=1;
                t=(a-1)*rand+1;
                
                Moth_pos(i,j)=distance_to_flame*exp(b.*t).*cos(t.*2*pi)+sorted_population(Flame_no,j);
            end
            
        end
        
    end
    
    Convergence_curve(Iteration)=Best_flame_score;
    
     if Iteration>2
        line([Iteration-1 Iteration], [Convergence_curve(Iteration-1) Convergence_curve(Iteration)],'Color','b')
        xlabel('Iteration');
        ylabel('Best score obtained so far');        
        drawnow
    end
 
    
    set(handles.itertext,'String', ['The current iteration is ', num2str(Iteration)])
    set(handles.optimumtext,'String', ['The current optimal value is ', num2str(Best_flame_score)])
    if value==1
        hold on
        scatter(Iteration*ones(1,N),All_fitness,'.','k')
    end
    
    Iteration=Iteration+1; 
end





