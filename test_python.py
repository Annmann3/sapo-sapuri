# coding: UTF-8
print ( "Hello Python" )
# graph_type graph_constance

import numpy as np
import matplotlib.pyplot as plt
 
 
class PoOneComp2:
    STEP = 0.01     # 経過時間の刻み幅
 
    def __init__(self, F, D, vd, ka, ke, interval):
        self.F = F
        self.D = D
        self.vd = vd
        self.ka = ka
        self.ke = ke
        self.interval = interval
        self.A = F * D * ka / vd / (ka - ke)
        self.t = np.linspace(0, interval, num=int(interval / PoOneComp2.STEP), endpoint=False)
 
    # n回目の1投与区間の血中濃度
    def get_section_conc(self, n):
        c = self.A * np.exp(-self.ke * self.t) * (1 - np.exp(-n * self.ke * self.interval)) \
            / (1 - np.exp(-self.ke * self.interval)) \
            - self.A * np.exp(-self.ka * self.t) * (1 - np.exp(-n * self.ka * self.interval)) \
            / (1 - np.exp(-self.ka * self.interval))
        return c.tolist()
 
    # 定常状態における最低血中濃度
    def get_cmin(self):
        cmin = self.A * np.exp(-self.ke * self.interval) / (1 - np.exp(-self.ke * self.interval)) \
            - self.A * np.exp(-self.ka * self.interval) / (1 - np.exp(-self.ka * self.interval))
        return cmin
 
    # 定常状態における最高血中濃度
    def get_cmax(self):
        tmax = self.get_tmax()
        cmax = self.A * np.exp(-self.ke * tmax) / (1 - np.exp(-self.ke * self.interval)) \
               - self.A * np.exp(-self.ka * tmax) / (1 - np.exp(-self.ka * self.interval))
        return cmax
 
    # 定常状態における最高血中濃度到達時間
    def get_tmax(self):
        tmax = np.log(self.ka / self.ke * (1 - np.exp(-self.ke * self.interval))
                      / (1 - np.exp(-self.ka * self.interval))) / (self.ka - self.ke)
        return tmax
 
    # AUC(投与間隔)
    def get_auc(self):
        return self.F * self.D / self.ke / self.vd
 
    # 定常状態における平均血中濃度
    def get_cssave(self):
        return self.get_auc() / self.interval
 
if __name__ == '__main__':
    # 薬物動態パラメータはテオフィリンのインタビューフォームより
    F = 1
    vd = 0.45 * 60
    ka = 0.29
    ke = 0.09
    days = 4  # 何日投与するか
 
    # 1回の投与量(mg), 投与間隔(hr)を変えて投与する.
    D_1, interval_1 = 200, 12
    D_2, interval_2 = 400, 24

    # インスタンス生成
    po1 = PoOneComp2(F, D_1, vd, ka, ke, interval_1)
    po2 = PoOneComp2(F, D_2, vd, ka, ke, interval_2)
 
    # 描画区間の投与回数
    n1 = int(days * 24 / interval_1)
    n2 = int(days * 24 / interval_2)
 
    conc1, conc2 = [], []
 
    # key: 色, value: (インスタンス, 投与回数, 血中濃度)
    po = {'blue': (po1, n1, conc1), 'red': (po2, n2, conc2)}
 
    period = 24 * days
    time = np.linspace(0, period, int(period / PoOneComp2.STEP), endpoint=False)
 
    for color, value in po.items():
        _po, n, conc = value
        # 各クラス毎に1~n回目の投与までの血中濃度を加えていく
        for i in range(1, n + 1):
            conc.extend(_po.get_section_conc(i))
        # 1回投与量, 1日投与回数
        dose = int(_po.D)
        num = int(24 / _po.interval)
        plt.plot(time, conc, c=color, alpha=0.8, label=str(dose) + 'mg×' + str(num) + '回/日')
        print('color: ', color)
        print('投与量: {}, 1日投与回数: {}'.format(dose, num))
        print('Css_min: ', _po.get_cmin())
        print('Css_max: ', _po.get_cmax())
        print('Tss_max: ', _po.get_tmax())
        print('AUC(投与間隔): ', _po.get_auc())
        print('Css_ave: ', _po.get_cssave())
        print('-' * 30)
 
    plt.title('テオフィリンの血中濃度推移(イメージ)')
    # 軸ラベルを表示
    plt.ylabel('血中濃度[μg/mL]')
    plt.xlabel('時間[hr]')
    plt.xlim(0, )
    # 目盛りを24時間毎にする
    plt.xticks(np.arange(0, time[-1] + 24, 24))
    plt.ylim(0, 14)
    plt.grid(linestyle='dashed')
    plt.legend()
    plt.show() 
    get_arr()
