function correction_phase_mask
%% ------- ��������� "���������� �����" �� ������� ������ "FFTW", fft -----
% -- �����������: ������� ����� �� "���" 5 ����� ������ ����������� �.�.---

% -----------------�������������� ������ �������---------------------------
Fs = 960;                % �����                     
t = 0 : 1/Fs : 1 - 1/Fs; % ������ ������� (�� 0 �� 1 ��� ������� ������������)
X = 220*sin(2 * pi * 120 * t + pi);
x1 = 120*cos(2*pi*100*t + pi/2);
x2 = 80*cos(2*pi*200*t + pi/3);
x3 = 50*cos(2*pi*300*t + pi/4);
Xt = X + x1 + x2 + x3;
subplot(4,1,1);
plot(t, Xt);
%% ----------------- ������������� ������ � ��������� ������� -------------
Y = fft(Xt);
df = Fs/length(Y);            % ���������� �� ������� 
f = (0 : 1 : length(Y)/2)*df; % ������ - ������ ������
subplot(4,1,2);
M = abs(Y)/length(Xt)*2;      % ����������� ������
M_rounded = int16(M(1:size(f, 2))); % �����
ind = find(M_rounded ~= 0);
stem(f(ind), M(ind), 'LineWidth', 2,'marker','none'); grid on;
title('����������� ������');
xlabel('�������, ��')
ylabel('���������, �'); xlim([min(f) max(f)]);
subplot(4,1,3);
P = angle(Y)*180/pi;                % ������� ������
stem(f, P(1:length(f)), 'LineWidth', 2,'marker','none'); grid on;
title('������� ������ ��� �����');
xlabel('�������, ��');
ylabel('����, ������'); xlim([min(f) max(f)]);
subplot(4,1,4);
stem(f(ind), P(ind), 'LineWidth', 2,'marker','none'); grid on;
title('������� ������ � ���������� ������')
xlabel('�������, ��');
ylabel('����, ������'); xlim([min(f) max(f)]);
end