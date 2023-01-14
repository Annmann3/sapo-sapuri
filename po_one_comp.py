import numpy as np
import matplotlib.pyplot as plt
 
# 1次吸収過程のある1コンパートメント経口投与モデル
 
class PoOneComp:
    def __init__(self, F, D, vd, ka, ke, lag_time):
        self.F = F
        self.D = D
        self.vd = vd
        self.ka = ka
        self.ke = ke
        self.lag_time = lag_time
        self.A = (F * D * ka) / vd / (ka - ke)
 
    # 吸収過程
    def absorption_process(self, t):
        return self.A * np.exp(-self.ka * (t - self.lag_time))
 
    # 消失過程
    def elimination_process(self, t):
        return self.A * np.exp(-self.ke * (t - self.lag_time))
 
    # Cmax到達時間
    def t_max(self):
        return np.log(self.ka / self.ke) / (self.ka - self.ke) + self.lag_time
 
    # 最高血中濃度
    def c_max(self):
        return self.F * self.D / self.vd * (self.ka / self.ke) ** (self.ke / (self.ke - self.ka))
    
class VcOneComp:
    def __init__(self, F, D, vd, ka, ke, lag_time):
        self.F = F
        self.D = D
        self.vd = vd
        self.ka = ka
        self.ke = ke
        self.lag_time = lag_time

    def c_vitamin(self, t):
        return self.F * self.D * self.ka / self.vd * np.exp(-self.ka * t) * t
 
 
F = 1.0     # 消化管からの吸収率
D = 100     # 経口投与量(mg)
vd = 12     # 分布容積(L)
ka = 0.4    # 吸収速度定数(hr^-1)
ke = 0.08   # 消失速度定数(hr^-1)
lag_time = 0    # 溶解時間(hr)
 
t = np.arange(0, 60, 0.1)
po = PoOneComp(F, D, vd, ka, ke, lag_time)
vc = VcOneComp(1, 1000, 35, 0.33, 0.33, 0)
 
c_ab = po.absorption_process(t)
c_eli = po.elimination_process(t)
 
tmax = po.t_max()
cmax = po.c_max()
 
print('A(縦軸との交点): ', po.A)
print('Tmax: ', tmax)
print('Cmax', cmax)
print('t_half: ', np.log(2) / ke)
print('AUC: ', F * D / vd / ke)
 
# 濃度式をプロット
plt.plot(t, c_eli, color='blue', alpha=0.8, label='c1:消失過程')
plt.plot(t, c_ab, color='red', alpha=0.8, label='c2:吸収過程')
plt.plot(t, c_eli-c_ab, color='green', alpha=0.8, label='c1-c2')
plt.plot(t, vc.c_vitamin(t), color='yellow', alpha=0.8, label='Vitamin C')
# tmaxに補助線を入れる
plt.vlines(x=tmax, ymin=0, ymax=cmax, color='crimson', linestyles='dotted')
# 軸ラベルを表示
plt.ylabel('conc[ug/mL]')
plt.xlabel('time[hr]')
plt.xlim(0, 60)
plt.ylim(0, )
plt.grid(linestyle='dashed')
plt.legend()
plt.show()
 
