# vtb_to_uvmtb
从基础的verilog TB逐步扩展至uvm tb的搭建过程（基于WUJIAN100中的dmac模块）
```
git clone https://github.com/IC-Design-Verify/vtb_to_uvmtb.git
```

##微信公众号相关代码环境介绍:

https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzkzMzY3NjUxMA==&action=getalbum&album_id=4150348287574540303#wechat_redirect

  ### 1.0 建立Verilog TestBench, 新建时钟复位，创建其他与DUT相关的信号，并设置初始值
```
git checkout tags/V1.0
```
  ### 1.1 创建用于读写寄存器的时序封装函数，以及用于对比的函数
```
git checkout tags/V1.1
```
  ### 1.2 使用interface封装信号
```
git checkout tags/V1.2
```
  ### 1.3 将函数封装到interface中
```
git checkout tags/V1.3
```
  ### 1.4 将ahb的读写操作从tb_top移植到ahb_driver中
```
git checkout tags/V1.4.1
```
  ### 1.5 driver封装在agent中，并使用agent_config管理interface和driver是否在agent中例化
```
git checkout tags/V1.5
```
  ### 1.6 添加sequence/sequencer，用于随机transaction在driver中发送
```
git checkout tags/V1.6
```
