% Set time scale, frequency scale and width
width = 10;
t = -25:25;
f = t/length(t);

% Original pulse and spectrum
pulse = zeros(1, length(t));
pulse((length(t)-width)/2:(length(t)+width)/2) = 1;
spectrum = fftshift(fft(pulse));

% ---- Time shifting ----
time_shift = -5;

% Applying property to original spectrum
time_shift_factor = exp(1i*2*pi*f*time_shift);
time_shifted_spectrum = spectrum.*time_shift_factor;
time_shifted_pulse = ifft(ifftshift(time_shifted_spectrum));

% ---- Frequency shifting ----
frequency_shift = 0.38;

% Applying property to original pulse
frequency_shift_factor = exp(1i*2*pi*t*frequency_shift);
frequency_shifted_pulse = pulse.*frequency_shift_factor;
frequency_shifted_spectrum = fftshift(fft(frequency_shifted_pulse));

% ---- Convolution ----
x1 = pulse;
X1 = fft(x1);
x2 = time_shifted_pulse;
X2 = fft(x2);
X3 = X1.*X2;
x3 = fftshift(ifft(X1.*X2));

% Original signal and its spectrum
figure(1);
subplot(2,1,1);
plot(t, pulse);
xlabel('Time');
ylabel('Amplitude');
title('Original Pulse');
ylim([-0.5, 1.5]);
grid;
subplot(2,1,2);
plot(f, abs(spectrum));
xlabel('Frequency');
ylabel('Magnitude');
title('Original Spectrum');
xlim([-0.5,0.5]);
grid;

% Time shifted signal and frequency shifted spectrum
figure(2);
subplot(2,1,1);
plot(t, time_shifted_pulse);
xlabel('Time');
ylabel('Amplitude');
title('Time shifted pulse using property');
ylim([-0.5, 1.5]);
grid;
subplot(2,1,2);
plot(f, abs(frequency_shifted_spectrum));
xlabel('Frequency');
ylabel('Magnitude');
title('Frequency shifted pulse using property');
xlim([-0.5,0.5]);
grid;

% Convolution
figure(3);
plot(t, x3);
xlabel('Time');
ylabel('Amplitude');
title('Convultion property of Fourrier Transform');
xlim([-10, 18]);
grid;