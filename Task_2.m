p0 = 0.05; y0 = 5;
VA = 1; VB = 0; VBn = 0;
A = 1; B = 1;
alpha0 = 1; beta0 = 1; alpha = []; beta = [];
iA = 0; iB = 0;
B_op = 0; N = 10;
for i = 1:1:N
    alpha(i) = exp(-p0*i); 
    beta(i) = 1-(i/(y0+i));
   if A == 1
%        if i > 9
%            VA(i + 1) = VBn(i);
%         if alpha(i) < VB(i)
%             VA(i+1) = VB(i);
        if alpha(i) < VBn(i)
            VA(i+1) = VBn(i);
        else
            VA(i+1) = alpha(i);
            iA = iA + 1;
        end
   else
        break
   end
   if B == 1
           if (1 - beta(i)) > VA(i)
               VB(i+1) = VA(i);
           else
               VB(i+1) = 1 - beta(i);
               iB = iB + 1;
           end
   end
   if B == 1
       if alpha(i) > 0.5 && beta(i) > 0.5
           VBn(i+1) = 1 - beta(i);
           %                iB = iB + 1;
       else
           VBn(i+1) = VA(i);
       end
   end
end

alpha = [alpha0 alpha];
beta = [beta0 beta];
 %%  Plot
figure(1)
plot(0:N, VA,'*-'); hold on;
plot(0:N, VB,'o-'); hold on; grid on;
xlabel('Distance between Players (i)'); ylabel('Value');
title('Value Functions'); legend('V^{A}_{N-i}','V^{B}_{N-i}'); 

figure(2)
plot(0:N, VA,'*-'); hold on;
plot(0:N, VB,'o-'); hold on; grid on;
plot(0:N, VBn,'^-'); hold on; grid on;
xlabel('Distance between Players (i)'); ylabel('Value');
title('Value Functions'); 
legend('V^{An}_{N-i}','V^{B}_{N-i}','V^{Bn}_{N-i}'); 

figure(3)
plot(1:N, VA(1:N),'*-'); hold on; grid on;
plot(1:N, 1 - beta(2:N+1),'o-');
xlim([1,N])
xlabel('Distance between Players (i)'); ylabel('Value');
title('Hitting probabilities and Value of the game')
legend('V^{A}_{N-i+1}','1-\beta_i')

figure(4)
% plot(1:N, VB(1:N),'*-'); hold on; grid on
plot(1:N, VBn(1:N),'*-'); hold on; grid on
plot(1:N, alpha(2:N+1),'o-');
xlim([1,N])
xlabel('Distance between Players (i)'); ylabel('Value');
title('Hitting probabilities and Value of the game')
legend('V^{B}_{N-i+1}','\alpha_i')


% figure(5)
% plot(1:N, VB(1:N)); hold on;
% plot(1:N, alpha(2:N+1));
% legend('VB','\alpha')
% plot(0:(length(VA)-1), VA);
% hold on 
% plot(0:(length(VB)-1), VB);
% hold on
% plot(0:(length(VB)-1), VBn);
% xlabel('Distance between players (i)');
% ylabel('Value');
% title('Value Functions for Players')
% legend('VA','VB','VB non-optimal');
% grid on;

%% Largest i
X = ['The largest distance when Annie should first shoot is ', num2str(iA)];
Y = ['The largest distance when Bruno should first shoot is ', num2str(iB)];
disp(X); disp(Y);

