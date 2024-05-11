Fs = 44100;   % Sampling frequency (Hz)
SNR = 10;     % Signal-to-noise ratio (dB)

% Generate time vector
t = 0:1/Fs:0.02;

% Generate clean signal
clean_signal = sin(2*pi*1000*t);

% Generate noise
noise_power = 10^(-SNR/10);
noise = sqrt(noise_power) * randn(size(t));

% Add noise to the clean signal
noisy_signal = clean_signal + noise;

% Scale the signal to fit within the range of a 16-bit integer
scaled_signal = int16(noisy_signal * (2^15 - 1));

% Convert the scaled signal to binary representation
binary_signal = dec2bin(typecast(scaled_signal, 'uint16'), 16);

% Save each 16-bit binary value on a separate line in the text file
fileID = fopen('binary_signal.txt', 'w');
for i = 1:size(binary_signal, 1)
    fprintf(fileID, '%s\n', binary_signal(i, :));
end
fclose(fileID);

% Plot the results
subplot(3,1,1);
plot(t,clean_signal);
xlabel('Time');
ylabel('Amplitude');
title('clean signal');

subplot(3,1,2);
plot(t,noise);
xlabel('Time');
ylabel('Amplitude');
title('noise');

subplot(3,1,3);
plot(t,noisy_signal);
xlabel('Time');
ylabel('Amplitude');
title('noisy signal');