% Set width and time scale
width = 38;
t = -50:50;

% Set the frequency scale
f = t/length(t);

% Create a vector of zeros with the same length as the time scale
pulse = zeros(1, length(t));

% Set the values within the pulse width to 1
pulse((length(t)-width)/2:(length(t)+width)/2) = 1;

% Take the Fourier transform of the pulse signal
P = fftshift(fft(pulse))/10;

% Time scaled pulse
a = 2;
scaled_pulse = zeros(1, length(t));
scaled_pulse((length(t)-(width/a))/2:(length(t)+(width/a))/2) = 1;

% Take the Fourier transform of the scaled pulse
SP = fftshift(fft(scaled_pulse));

% Plot the pulse
figure(1);
subplot(2,1,1);
plot(t, pulse);
xlabel('Time');
ylabel('Amplitude');
title('Pulse of Width 38');
ylim([-0.5, 1.5]);
grid;

% Plot the magnitude spectrum of the pulse signal
subplot(2,1,2);
plot(f, abs(P));
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Spectrum of Pulse of Width 38');
xlim([-0.2,0.2]);
grid;

% Plot the time scaled pulse
figure(2);
subplot(2,1,1);
plot(t, scaled_pulse);
xlabel('Time');
ylabel('Amplitude');
title('Pulse of Width 38/2');
ylim([-0.5, 1.5]);
grid;

% Plot the magnitude spectrum of the time scaled pulse signal
subplot(2,1,2);
plot(f, abs(SP));
xlabel('Frequency');
ylabel('Magnitude');
title('Magnitude Spectrum of Pulse of Width 38/2');
xlim([-0.2,0.2]);
grid;