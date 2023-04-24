Q = 38;
N = 10^4;

S1 = rand(1, N)-0.5;
S2 = randn(1, N)*var(S1) + mean(S1);

[SQNR1, theoreticalSQNR1] = uniformQuantizationSQNR(S1, Q);
[SQNR2, theoreticalSQNR2] = uniformQuantizationSQNR(S2, Q);

% plot
figure(1);
plot((1:Q), SQNR1, 'g', 'LineWidth', 2);
hold on;
plot((1:Q), theoreticalSQNR1, 'r--', 'LineWidth', 0.5);
plot((1:Q), SQNR2, 'Color','#FFA500', 'LineWidth', 2);
plot((1:Q), theoreticalSQNR2, 'b--', 'LineWidth', 0.5);
hold off;
ylabel('SQNR in decibels'); xlabel('Quantization level');
legend('calculated SQNR of S1', 'theoretical SQNR of S1', ...
'calculated SQNR of S2','theoretical SQNR of S2', 'location','southeast');
grid on;

% verification
verification(SQNR1, theoreticalSQNR1, 'S1');
verification(SQNR2, theoreticalSQNR2, 'S2');

function [SQNR, theoreticalSQNR] = uniformQuantizationSQNR(S, Q)
    mx = max(S);
    mn = min(S);
    N = length(S);
    QN = zeros(1, Q);
    for q = 1:Q
        d = (mx - mn)/q;
    
        level = floor((S - mn)./d);
        quantized = (2.*level + 1).*(d/2) + mn;
        
        QN(1, q) = sum((S - quantized).^2)./N;
    end
    
    % average signal power
    Ps = sum((S).^2)./N;
    
    % Calculate Signal to Quantization Noise Ratio in decibels
    SQNR = 10*log10(Ps./QN);

    theoreticalSQNR = 6.02.*log2(1:Q) + 10*log10(3*Ps/max(S)^2);
end

function verification(c, t, name)
    Q = length(c);
    msgc = ['Calculated SQNR of ', name, ': '];
    disp(msgc);disp(entries( dictionary((1:Q), c) ));
    msgt = ['Theoretical SQNR of ', name, ': '];
    disp(msgt);disp(entries( dictionary((1:Q), t) ));
    
    disp(['Average error between calculated and theoretical SQNR = ', ...
        num2str(sum(abs(c-t))/length(c))]);
end