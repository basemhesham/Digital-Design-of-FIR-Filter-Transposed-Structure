# Digital-Design-of-FIR-Filter-Transposed-Structure
This repository presents Digital design for Low pass FIR filter. This has been implemented by using Verilog description language and has been simulated on VIVADO.

## Introduction

An FIR (Finite Impulse Response) filter is a type of digital filter used in signal processing. It operates by convolving a finite-length input signal with a series of coefficients, which are typically called the filter taps. These coefficients determine how the input signal is weighted and combined to produce the output signal.      FIR filters are is widely used in different applications such as biomedical, communication and control due to its easily implementation, stability and best performance. Its simplicity makes it attractive for many applications where it is need to minimize computational requirements.

# FIR Direct architecture
Digital filters are implemented using the basic building block elements of adders, multipliers, and shift registers. How these elements are arranged and interconnected defines a filter ’ s architecture. In general, a given filter can have multiple architectures that can be used to implement a common transfer function.

![Fig1m5182018](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/f7b1c4b4-a9e6-4cdd-978c-9d3b693508fd)

# FIR Transposed architecture
Another baseline FIR architecture is called the transpose FIR, which is a variation of the direct architecture theme. An FIR, with an impulse response ℎ[𝑘]={ℎ_0  , ℎ_1  , . . . , ℎ_(𝑁−1)} can be implemented as the transpose architecture shown in the following Figure

Comparing with the direct form we observe that the order of the filter coefficients is reversed, And the input reaches all the multipliers at the same time This is in contrast to the direct form structure where a given input sample reaches the multipliers at different clock cycles.

![Fig8m5182018](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/915fa8cd-a161-41d7-8fe3-9b80cd304a13)

# Filter Specifications
we will design an audio lowpass filter that operates at a sampling rate of 44.1kHz which are standard sampling rate for audio applications. Let's say you want to design a FIR LPF for audio signal processing with a cutoff frequency of 4 kHz. We must also specify the word length of the coefficients, which in this case is 16 bits, assuming a 16-bit fixed-point DSP is to be used.
 We can design FIR LPF using various methods such as windowing, frequency sampling, or optimization techniques. The filter length and the coefficients will depend on the specific design method you choose and the desired filter characteristics. We will use window method in our design.
![img2](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/bf1671f6-76a9-4f25-8bcd-679555c20afa)

 - Filter Type: Lowpass
 - Sampling Frequency: 44,100Hz
 - Cutoff Frequency: 4,000Hz
 - Word length: 16-bits

# MATLAB Modelling
Now we can design our filter based on the previous specifications using Filter Designer tool by the following command: filterDesigner 
![MATLAB GUI](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/5989b1d2-c6ae-4ed1-a4f4-a2777ab37b4b)

## Magnitude and Phase Response
![phase and magnitude response](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/a5e8a046-512d-47c7-b47b-a73cc8cb0c5a)

## Pole-Zero Plot
![pole-zero plot](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/df2e9ec4-ee63-461d-aee7-341c2a8287b5)

## Filter Coefficients
The following step is to get the filter coefficients from File>Export>Coefficient File (ASCII) and choose decimal format. 

![filter coefficients](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/a068ee7f-42bc-458a-9f1a-31d0a6566c71)

## Convert coefficients from decimal to binary
To represent floating number in binary we use python script "floating_binary.py" truncate the numbers to just the 7 digits after the decimal point and write the new values after truncated then converted it to binary.

##  Generating Noisy Signal 
This MATLAB script generates a noisy signal by adding random noise to a clean sinusoidal signal. 
the script first calculates the power of the noise based on the specified SNR, and then generates Gaussian noise samples with that power to add to the clean signal.

![matlabsignal](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/ff81eced-09c6-4165-9a53-8aa4faa17f27)


# Simulation
After the fifty-clock edge, we have the output:
\[ y(n) = b_{50} x(n-50) + b_{49} x(n-49) + \ldots + b_2 x(n-2) + b_1 x(n-1) + b_0 x(n) \]

## Test case 1
data_in : noisy signal =  (sin⁡(2𝜋∗1000∗𝑡) + noise)
<br> <br>
data_out : filtered signal = sin⁡(2𝜋∗1000∗𝑡) 

![simulation1](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/e8fb552a-fb86-48ba-bf6f-9fa9a7d709a2)
We can notice that the original signal is recovered successfully with an acceptable delay that was expected due to the filter hardware stages.

## Test case 2
data_in : signal with two frequencies  = sin⁡(2𝜋∗1000t) +cos⁡(2𝜋∗20000t);
<br> <br>
data_out : filtered signal = sin⁡(2𝜋∗1000t) 

![simulation2](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/7bd2e471-a0e0-49bf-a5fa-dc2edd8fa5c8)
We can notice that the frequency 20KHz is filtered and frequency 2KHz is passed  

## Test case 3
data_in : signal with two high frequencies  = sin⁡(2𝜋∗8000t) + cos⁡(2𝜋∗20000t);
<br> <br>
data_out : filtered signal ≈0

![simulation3](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/23bdf559-bdd5-48a1-b395-6e05e15166c2)

We can notice that the both frequencies 20KHz and 8KHz is filtered

## Test case 4
data_in : sin⁡(2𝜋∗1000t)
<br> <br>
data_out : the same signal =sin⁡(2𝜋∗1000t)

![simulation4](https://github.com/basemhesham/Digital-Design-of-FIR-Filter-Transposed-Structure/assets/136960296/8ed75552-1a4d-4955-94e7-e6afd217f3bf)

We can notice that the frequency 1KHz which is below cutoff frequency is passed



