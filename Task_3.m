p0 = 0.05; y0 = 5;
N = 10;
VA = zeros(N+1,1); VB = zeros(N+1,1);
VA(N+1,1) = 1; VB(N+1,1) = 0;
alpha = []; beta = [];
VA_hat = []; VA_hat1 = []; VA_hat2 = [];
nA = 0;
B_op = 0;
for i = 1:1:N
    alpha(i) = exp(-p0*i); 
    beta(i) = 1-(i/(y0+i));
    VA(N-i+1,1) = max(alpha(i),VB(N-i+2,1));
    VB(N-i+1,1) = min((1-beta(i)),VA(N-i+2,1));
end

for simu = 1 : 100000000
    for j = N : -1 : 0
        if mod(j,2) == 0 % to calculate this round is whoes turn
            if j <= 5 % j <= 5 (A knows B's non-optimal strategy)
                if rand < alpha(j) % the random number is to randomly test which one is win in this turn
                    nA = nA + 1;
                end
                break;
            end
        else
            if B_op == 1
                if j <= 9
                    if rand < 1 - beta(j)
                        nA = nA + 1;
                    end
                    break;
                end
            else
                if alpha(j) > 0.5 && beta(j) > 0.5
                    if rand < 1 - beta(j)
                        nA = nA + 1; 
                    end
                    break;
                end
            end
        end
    end
end
VA_hat1 = nA/simu;
% VA_hat2 = nA/simu;
%% Value of the game
if B_op == 1
    X = ('The optimal value of the game when both players take optimal strategies is ');
    X1 = ['                                                                           ', num2str(VA(1),4)]; 
    Y = ['The propotion of times that Annie wins over ', num2str(simu), ' simulations when both players take optimal strategies is '];
    Y1 = ['                                                                                                         ', num2str(VA_hat1,4)]; 
else
    X = ('The optimal value of the game when both players take optimal strategies is ');
    X1 = ['                                                                           ', num2str(VA(1),4)]; 
    Y = ['The propotion of times that Annie wins over ', num2str(simu), ' simulations when Bruno takes non-optimal strategy is '];
    Y1 = ['                                                                                                     ', num2str(VA_hat1,4)]; 
end
disp(X); disp(X1); disp(Y); disp(Y1);